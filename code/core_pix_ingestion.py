import pandas as pd
import logging
from sqlalchemy import create_engine

logging.basicConfig(
    level=logging.INFO,  # Mostra logs INFO ou superiores
    format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)

try:
    # Caminho do CSV
    csv_file = "./raw_data/core_pix.csv"
    logger.info(f"Lendo o arquivo CSV: {csv_file}")

    # Leitura do CSV
    df = pd.read_csv(csv_file)
    logger.info(f"Arquivo csv lido com sucesso! Total de linhas: {len(df)}")

    # print(df.dtypes)

    # Conexão com Postgres
    host = "localhost"
    port = 5432
    database = "postgres"
    user = "postgres"
    password = "postgres"

    # Criar engine
    engine = create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}")
    logger.info("Conexão com o banco de dados criada com sucesso.")

    # Escrita dos dados na tabela presente no schema 'raw'
    df.to_sql(
        "core_pix",
        engine,
        schema="raw",
        if_exists="fail", 
        index=False
    )
    logger.info("Dados inseridos com sucesso na tabela 'raw.core_account'.")


except Exception as e:
    logger.error(f"Ocorreu um erro: {e}")