import os
import mysql.connector


def get_db_connection():
        
    return mysql.connector.connect(

        host=os.getenv("AZURE_MYSQL_HOST"),

        user=os.getenv("AZURE_MYSQL_USER"),

        password=os.getenv("AZURE_MYSQL_PASSWORD"),

        database=os.getenv("AZURE_MYSQL_NAME"),

        port=int(os.getenv("AZURE_MYSQL_PORT", 3306)),

        ssl_disabled=False,
    )

 
   