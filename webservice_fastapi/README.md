# Backend API - Mahasiswa Connect

Ini adalah backend REST API untuk aplikasi Mahasiswa Connect menggunakan FastAPI dan MySQL.

## 🚀 Teknologi
- FastAPI
- MySQL
- PyMySQL
- Uvicorn
- Pydantic

## ⚙️ Setup & Menjalankan Server
### 1. Import Database
Import Database file mahasiswa_db yang ada di folder database ke dalam mysql

### 2. Install  dan Aktifkan Virtual Environment (opsional tapi disarankan)
#### 2.1 Install Virtual Env
Buka CMD atau Terminal dan pastikan didalam folder werservice_fastapi dan jalankan perintah dibawah ini
```bash
pip install virtualenv
python -m venv env
```
#### 2.2 AKtifkan Virtual Env
```bash
source env/bin/activate        # (Linux/Mac)
env\Scripts\activate           # (Windows)
```
### 3. Install Dependencies
```bash
pip install -r requirements.txt
```
### 4. Jalankan FastApi Server
```bash
uvicorn main:app --reload
uvicorn main:app --reload --host 0.0.0.0 --port 8000 # Jalan ini yang ini Setalah Poject flutter sudah siap diTesting
```
Server akan berjalan di http://127.0.0.1:8000 atau http://127.0.0.1:8000/docs

![Tampilan Api](images/Api.png)
