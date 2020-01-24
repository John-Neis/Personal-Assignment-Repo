import mysql.connector
from mysql.connector import errorcode


def foo(x, y):
    print(x + y)



try:
    cnx = mysql.connector.connect(
        user='root', 
        password='pass260word', 
        host='127.0.0.1', 
        database='bankusers'
    )
    print("Database Connected")
    foo(5, 10)
    cursor = cnx.cursor()
    sql = "SELECT * FROM users;"

    cursor.execute(sql)
    records = cursor.fetchall()

    for record in records:
        print(record)

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your login credentials")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Incorrect database entered")
    else:
        print(err)
else:
    cnx.close()

