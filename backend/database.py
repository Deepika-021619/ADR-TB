import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="tbadrmysql-deepika235114-523d.f.aivencloud.com",
        user="avnadmin",
        password="AVNS_mqG_RCxDY-Qza9kHvow",
        database="tbadr_app",
        port=27424,
        ssl_disabled=False
    )


