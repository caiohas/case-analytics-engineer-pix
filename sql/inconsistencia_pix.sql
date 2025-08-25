with transacoes_nao_registradas_pix as (
    select
        ca.id_transaction,
        'transacao nao registrada core pix' as inconsistencia
    from silver.core_account ca
    left join silver.core_pix cp 
        on ca.id_transaction = cp.id_transaction 
    where cp.id_transaction is null
),
transacoes_nao_registradas_account as (
    select
        cp.id_transaction,
        'transacao nao registrada core account' as inconsistencia
    from silver.core_pix cp 
    left join silver.core_account ca
        on ca.id_transaction = cp.id_transaction 
    where ca.id_transaction is null
),
valores_divergentes as (
    select
        ca.id_transaction,
        'valores divergentes core account e core pix' as inconsistencia
    from silver.core_account ca
    left join silver.core_pix cp 
        on ca.id_transaction = cp.id_transaction 
    where ca.vl_transaction != cp.vl_transaction 
),
datas_divergentes as (
    select
        ca.id_transaction,
        'datas divergentes core account e core pix' as inconsistencia
    from silver.core_account ca
    left join silver.core_pix cp 
        on ca.id_transaction = cp.id_transaction 
    where ca.dt_transaction != cp.dt_transaction 
)
select * from transacoes_nao_registradas_pix
union all
select * from transacoes_nao_registradas_account
union all
select * from valores_divergentes
union all
select * from datas_divergentes;
