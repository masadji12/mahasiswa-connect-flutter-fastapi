from fastapi import APIRouter, HTTPException
from models.mahasiswa_model import Mahasiswa, CreateMahasiswa
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

@route.post("/mahasiswa")
def create_mahasiswa(m: CreateMahasiswa):
    try:
        con = get_connection()
        cursor = con.cursor()
        query = "INSERT INTO mahasiswa (nama, nim, id_prov, angkatan, tinggi_badan) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(query, (m.nama, m.nim, m.id_prov, m.angkatan, m.tinggi_badan))
        con.commit()
        cursor.close()
        con.close()
        return {"Pesan": "Mahasiswa Berhasil ditambahkan"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
