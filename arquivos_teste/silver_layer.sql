-- silver.core_account
create table if not exists silver.core_account (
    id_transaction varchar primary key,
    dt_transaction date,
    dt_month date,
    cd_account_customer integer,
    cd_seqlan integer,
    ds_transaction_type varchar,
    vl_transaction double precision
);

insert into silver.core_account (
    id_transaction,
    dt_transaction,
    dt_month,
    cd_account_customer,
    cd_seqlan,
    ds_transaction_type,
    vl_transaction
)
with dedup as (
    select
        *,
        row_number() over (partition by id_transaction order by dt_transaction desc) as rn
    from bronze.core_account
)
select
    id_transaction,
    dt_transaction,
    dt_month,
    cd_account_customer,
    cd_seqlan,
    ds_transaction_type,
    vl_transaction
from dedup
where rn = 1;

-- silver.core_pix
create table if not exists silver.core_pix (
    id_transaction varchar primary key,
    dt_transaction date,
    dt_month date,
    cd_seqlan integer,
    ds_transaction_type varchar,
    vl_transaction double precision
);

insert into silver.core_pix (
    id_transaction,
    dt_transaction,
    dt_month,
    cd_seqlan,
    ds_transaction_type,
    vl_transaction
)
with dedup as (
    select
        *,
        row_number() over (partition by id_transaction order by dt_transaction desc) as rn
    from bronze.core_pix
)
select
    id_transaction,
    dt_transaction,
    dt_month,
    cd_seqlan,
    ds_transaction_type,
    vl_transaction
from dedup
where rn = 1;

-- silver.customer
create table if not exists silver.customer (
    cd_account_customer integer primary key,
    entry_date date,
    full_name varchar,
    birth_date date,
    uf_name varchar,
    uf varchar,
    street_name varchar
);

insert into silver.customer (
    cd_account_customer,
    entry_date,
    full_name,
    birth_date,
    uf_name,
    uf,
    street_name
)
with dedup as (
    select
        *,
        row_number() over (partition by cd_account_customer order by entry_date desc) as rn
    from bronze.customer
)
select
    cd_account_customer,
    entry_date,
    full_name,
    birth_date,
    uf_name,
    uf,
    street_name
from dedup
where rn = 1;
