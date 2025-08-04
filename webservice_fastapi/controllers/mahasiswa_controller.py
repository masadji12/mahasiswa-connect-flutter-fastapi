from fastapi import APIRouter, HTTPException
from models.mahasiswa_model import Mahasiswa, CreateMahasiswa, UpdateMahasiswa
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
        mahasiswa_id = cursor.lastrowid
        cursor.close()
        con.close()
        return {
            "id": mahasiswa_id,
            "nama": m.nama,
            "nim": m.nim,
            "id_prov": m.id_prov,
            "angkatan": m.angkatan,
            "tinggi_badan": m.tinggi_badan,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@route.patch("/mahasiswa/{id}")
def patch_mahasiswa(id: int, m: UpdateMahasiswa):
    try:
        con = get_connection()
        cursor = con.cursor()

        update_fields = []
        values = []

        if m.nama is not None:
            update_fields.append("nama = %s")
            values.append(m.nama)
        if m.nim is not None:
            update_fields.append("nim = %s")
            values.append(m.nim)
        if m.id_prov is not None:
            update_fields.append("id_prov = %s")
            values.append(m.id_prov)
        if m.angkatan is not None:
            update_fields.append("angkatan = %s")
            values.append(m.angkatan)
        if m.tinggi_badan is not None:
            update_fields.append("tinggi_badan = %s")
            values.append(m.tinggi_badan)

        if not update_fields:
            raise HTTPException(status_code=400, detail="Tidak ada data yang dikirim untuk diupdate.")

        query = f"UPDATE mahasiswa SET {', '.join(update_fields)} WHERE id = %s"
        values.append(id)

        cursor.execute(query, values)
        con.commit()
        cursor.close()
        con.close()
        return {"pesan": "Data mahasiswa berhasil diperbarui"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@route.delete("/mahasiswa/{id}")
def delete_mahasiswa(id: int):
    try:
        con = get_connection()
        cursor = con.cursor()
        query = """DELETE FROM mahasiswa WHERE id = %s"""
        cursor.execute(query, (id,))
        con.commit()
        cursor.close()
        con.close()
        return{"Pesan": "Mahasiswa id {id} berhasil dihapus"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))