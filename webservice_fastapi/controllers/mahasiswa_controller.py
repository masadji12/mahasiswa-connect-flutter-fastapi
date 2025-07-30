from fastapi import APIRouter, HTTPException
from models.mahasiswa_model import Mahasiswa
from db.database import get_connection

route = APIRouter()

@route.get("/mahasiswa")
def get_all_mahasiswa():
    try:
        con = get_connection()
        cursor = con.cursor()
        query = "SELECT * FROM mahasiswa"
        cursor.execute(query)
        result = cursor.fetchall()
        cursor.close()
        con.close()
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
