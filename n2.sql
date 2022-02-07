SELECT 
	DB_NAME([DES].[database_id]) AS [dbname],
[DES].[host_name],
	[DER].[session_id],
	'KILL ' + CAST([DER].[session_id] AS VARCHAR(500)),
	[DES].[login_name],
	[DER].[blocking_session_id],
	(
		SELECT TOP 1
			[DEST].[text]
		FROM 
			[sys].[dm_exec_connections] AS [DEC]
			CROSS APPLY [sys].[dm_exec_sql_text]([DEC].[most_recent_sql_handle]) AS [DEST]
		WHERE
			[DEC].[session_id] = [DER].[blocking_session_id]
	) AS [BlockingQuery],
	(
		SELECT TOP 1
			[DES].[host_name]
		FROM 
			[sys].[dm_exec_sessions] AS [DES]
		WHERE
			[DES].[session_id] = [DER].[blocking_session_id]
	) AS [BlockingQueryHost],
	(
		SELECT TOP 1
			[DES].[status]
		FROM 
			[sys].[dm_exec_sessions] AS [DES]
		WHERE
			[DES].[session_id] = [DER].[blocking_session_id]
	) AS [BlockingQueryState],
	[DER].[total_elapsed_time],
	[DER].[cpu_time],
	[DER].[wait_type],
	[DER].[wait_time],
	[DER].[status],
	[DER].[command],
	[DES].[host_name],
	[DER].[percent_complete],
	[DER].[estimated_completion_time]/1000.0 AS [estimated_completion_time],
	( 
		SELECT TOP 1
               SUBSTRING
			   (
					[DEST].[text] , [DER].[statement_start_offset] / 2 + 1,
					( 
						( 
							CASE WHEN [DER].[statement_end_offset] = -1
								THEN ( LEN(CONVERT(NVARCHAR(MAX), [DEST].[text])) * 2 )
							ELSE [DER].[statement_end_offset]
								END 
						) - [DER].[statement_start_offset] 
					) / 2 + 1
				)
     ) AS CurrentSqlStatement ,
	[DEST].[text],
	qp.query_plan,
	[DER].[sql_handle]
FROM 
	[sys].[dm_exec_requests] AS [DER]
	JOIN [sys].[dm_exec_sessions] AS [DES]
	ON [DES].[session_id] = [DER].[session_id]
	CROSS APPLY [sys].[dm_exec_sql_text]([DER].[sql_handle]) AS [DEST]
	CROSS APPLY sys.dm_exec_query_plan([DER].plan_handle) qp
--WHERE [DER].[command] = 'DbccFilesCompact'
ORDER BY [DER].[cpu_time] DESC
