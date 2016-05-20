select status from v$instance;

show parameter processes;

select * from v$resource_limit where resource_name = 'processes';