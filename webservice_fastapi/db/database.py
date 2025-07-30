import pymysql
from pymysql.cursors import DictCursor

def get_connection():
    return pymysql.connect(
        host= "localhost",
        user="root",
        password="",
        database="mahasiswa_db",
        cursorclass=DictCursor
)

# cursor.execute("SELECT * FROM mahasiswa")

# result = cursor.fetchall()
# for row in result:
#     print(row)

# cursor.close()
# mydb.close()