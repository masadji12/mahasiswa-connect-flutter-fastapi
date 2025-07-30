import pymysql;

mydb = pymysql.connect(
    host= "localhost",
    user="root",
    password="",
    database="mahasiswa_db",
)

cursor = mydb.cursor()

# cursor.execute("SELECT * FROM mahasiswa")

# result = cursor.fetchall()
# for row in result:
#     print(row)

# cursor.close()
# mydb.close()