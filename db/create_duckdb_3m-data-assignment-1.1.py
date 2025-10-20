import duckdb

con = duckdb.connect("db/3m-data-assignment-1.1.db")

con.sql(
    "CREATE TABLE vgsales AS SELECT * FROM read_csv_auto('db/vgsales.csv', HEADER=TRUE);"
)
# conda create -n env3m11 python=3.10
# conda activate env3m11
# conda install -c conda-forge duckdb

# python db/create_duckdb_3m-data-assignment-1.1.py

# conda deactivate
# conda remove -n env3m11 --all

# \\wsl.localhost\Ubuntu\home\localuser\github\3m-data-assignment-1.1\db\3m-data-assignment-1.1.db
