EXEC dbo.sp_WhoIsActive
    @show_system_spids = 0
  , @show_sleeping_spids = 0
  , @get_full_inner_text = 0
  , @get_plans = 1
  , @get_outer_command = 1
  , @get_transaction_info = 0
  , @get_task_info = 1
  , @get_additional_info = 1
  , @find_block_leaders = 1
  , @delta_interval = 0
  , @output_column_list = '[dd%][status][ses%][data%][reads][writes][physical_reads][bl%][sql_t%][query%][wait_info][sql_c%][login_n%][open_tran%][wait_info][hos%][%]'
  , @sort_order = '[CPU] DESC'
  , @format_output = 1
-- Filter Areas 

-- Database
  --, @filter = 'ALLSAFE01D'
  --, @filter_type = 'database'

-- Login
  --, @filter = 'Ikleiman'
  --, @filter_type = 'login'

-- Host
  --, @filter = 'RECAPIWEB00'
  --, @filter_type = 'host'

-- Program
  --, @filter = 'Service%'
  --, @filter_type = 'program'

-- Session
  --, @filter = 70
  --, @filter_type = 'session'

-- Not-Filter Areas

-- Database
  --, @not_filter = ''
  --, @not_filter_type = 'database'
  
-- Login
  --, @not_filter = ''
  --, @not_filter_type = 'login'

-- Host
  --, @not_filter = 'RECAPIWEB00'
  --, @not_filter_type = 'host'

-- Program
  --, @not_filter = ''
  --, @not_filter_type = 'program'

-- Session
  --, @not_filter = 97
  --, @not_filter_type = 'session'

  --, @get_locks = 1
  --, @show_own_spid = DEFAULT
  --, @get_avg_time = 1
  --, @destination_table = 'Audit.dbo.sp_whoisactive_output'
  --, @return_schema = 0
  --, @help = DEFAULT
  --, @schema = DEFAULT
--*/

GO
