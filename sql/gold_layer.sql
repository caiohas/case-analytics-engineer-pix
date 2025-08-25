-- gold.core_account
create table gold.core_account as (
select 
	dt_month
	,count(id_transaction) as qtd_requisicoes_pix
	,round(sum(vl_transaction)::numeric,2) as vlr_total_requisicoes_pix
	,round(avg(vl_transaction)::numeric,2) as vlr_medio_requisicoes_pix
from silver.core_account
group by dt_month
)

-- gold.core_pix
create table gold.core_pix as (
select 
	dt_month
	,count(id_transaction) as qtd_envios_pix
	,round(sum(vl_transaction)::numeric,2) as vlr_total_envios_pix
	,round(avg(vl_transaction)::numeric,2) as vlr_medio_envios_pix
from silver.core_pix
group by dt_month
)

-- gold.customer
create table gold.customer as (
select 
	cast(date_trunc('month', entry_date) as date) as data_entrada
	,count(cd_account_customer ) as qtd_contas_base
from silver.customer
group by cast(date_trunc('month', entry_date) as date) 
)