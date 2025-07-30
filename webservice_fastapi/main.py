from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from controllers import mahasiswa_controller

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

app.include_router(mahasiswa_controller.route)

app.get("/")
def read_root():
    return{"Pesan": "API sedang berjalan"}