-- bronze.core_account
drop table if exists bronze.core_account;

create table bronze.core_account as
select
    id_transaction::varchar as id_transaction,                           
    dt_transaction::date as dt_transaction,                             
    to_date(dt_month::text, 'YYYYMM')::date as dt_month,                 
    surrogate_key::integer as cd_account_customer,                           
    cd_seqlan::integer as cd_seqlan,                                     
    ds_transaction_type::varchar as ds_transaction_type,                 
    vl_transaction::double precision as vl_transaction                  
from raw.core_account;

-- bronze.core_pix
drop table if exists bronze.core_pix;

create table bronze.core_pix as
select
    id_transaction::varchar as id_transaction,
    dt_transaction::date as dt_transaction,
    to_date(dt_month::text, 'YYYYMM')::date as dt_month, 
    cd_seqlan::integer as cd_seqlan,
    ds_transaction_type::varchar as ds_transaction_type,
    vl_transaction::double precision as vl_transaction
from raw.core_pix;

-- bronze.customer
drop table if exists bronze.customer;

create table bronze.customer as
select
    surrogate_key::integer as cd_account_customer,
    entry_date::date as entry_date,
    full_name::varchar as full_name,
    birth_date::date as birth_date,
    uf_name::varchar as uf_name,
    uf::varchar as uf,
    street_name::varchar as street_name
from raw.customer;
