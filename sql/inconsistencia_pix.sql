WITH transacoes_nao_registradas_pix AS (
    SELECT
        ca.id_transaction,
        'transacao nao registrada CORE PIX' AS inconsistencia
    FROM silver.core_account ca
    LEFT JOIN silver.core_pix cp 
        ON ca.id_transaction = cp.id_transaction 
    WHERE cp.id_transaction IS NULL
    LIMIT 100
),
transacoes_nao_registradas_account AS (
    SELECT
        cp.id_transaction,
        'transacao nao registrada CORE ACCOUNT' AS inconsistencia
    FROM silver.core_pix cp 
    LEFT JOIN silver.core_account ca
        ON ca.id_transaction = cp.id_transaction 
    WHERE ca.id_transaction IS NULL
),
valores_divergentes AS (
    SELECT
        ca.id_transaction,
        'valores divergentes CORE ACCOUNT e CORE PIX' AS inconsistencia
    FROM silver.core_account ca
    LEFT JOIN silver.core_pix cp 
        ON ca.id_transaction = cp.id_transaction 
    WHERE ca.vl_transaction != cp.vl_transaction 
    LIMIT 100
),
datas_divergentes AS (
    SELECT
        ca.id_transaction,
        'datas divergentes CORE ACCOUNT e CORE PIX' AS inconsistencia
    FROM silver.core_account ca
    LEFT JOIN silver.core_pix cp 
        ON ca.id_transaction = cp.id_transaction 
    WHERE ca.dt_transaction != cp.dt_transaction 
    LIMIT 100
)
SELECT * FROM transacoes_nao_registradas_pix
UNION all
SELECT * FROM transacoes_nao_registradas_account
UNION ALL
SELECT * FROM valores_divergentes
UNION ALL
SELECT * FROM datas_divergentes;
