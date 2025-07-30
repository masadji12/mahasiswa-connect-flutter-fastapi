from pydantic import BaseModel

class CreateMahasiswa(BaseModel):
    nama: str
    nim: str
    id_prov: str
    angkatan: str
    tinggi_badan: int

class Mahasiswa(CreateMahasiswa):
    id: int  # Untuk response (GET)

class UpdateMahasiswa(BaseModel):
    nama: str | None = None
    nim: str | None = None
    id_prov: str | None = None
    angkatan: str | None = None
    tinggi_badan: int | None = None
