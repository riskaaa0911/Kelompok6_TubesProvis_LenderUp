# conda activate webservicep2plending webservicep2plending
# uvicorn main:app --reload
from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel
from typing import Optional
from typing import Union
from fastapi import FastAPI, Response, Request, HTTPException, Depends, Form
from fastapi.middleware.cors import CORSMiddleware
import sqlite3
from fastapi import status, Cookie
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from datetime import datetime, timedelta
from jose import JWTError, jwt

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# panggil sekali saja


@app.get("/init/")
def init_faq():
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        # Buat tabel FAQ
        create_table = """ CREATE TABLE faq(
            ID      	INTEGER PRIMARY KEY 	AUTOINCREMENT,
            pertanyaan 	TEXT            	NOT NULL,
            jawaban    	TEXT            	NOT NULL
        )  
        """
        cur.execute(create_table)
        # Buat tabel Akun
        create_akun_table = """CREATE TABLE IF NOT EXISTS akun (
                                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                                username TEXT NOT NULL,
                                email TEXT NOT NULL,
                                password TEXT NOT NULL,
                                token TEXT
                                )"""
        cur.execute(create_akun_table)

        con.commit()
        # Insert data FAQ ke dalam tabel

    except:
        return ({"status": "Terjadi error"})

    finally:
        con.close()

    return ({"status": "OK, tabel FAQ berhasil diinisialisasi"})


class FAQ(BaseModel):
    pertanyaan: str
    jawaban: str


class Akun(BaseModel):
    username: str
    email: str
    password: str
# status code 201 standard return creation
# return objek yang baru dicreate (response_model tipenya Mhs)


@app.post("/tambah_faq/", response_model=FAQ, status_code=201)
def tambah_faq(faq: FAQ, response: Response, request: Request):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute(
            """INSERT INTO faq (pertanyaan, jawaban) VALUES ("{}", "{}")""".format(
                faq.pertanyaan, faq.jawaban
            )
        )
        con.commit()
    except:
        print("Terjadi error")
        return {"status": "Terjadi error"}
    finally:
        con.close()
    response.headers["Location"] = "/faq/{}".format(faq.id)
    print(faq.pertanyaan)
    print(faq.jawaban)

    return faq


@app.get("/tampilkan_semua_faq/")
def tampil_semua_faq():
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        recs = []
        for row in cur.execute("SELECT * FROM faq"):
            faq = FAQ(id=row[0], pertanyaan=row[1], jawaban=row[2])
            recs.append(faq)
    except:
        return {"status": "Terjadi error"}
    finally:
        con.close()
    return {"data": recs}


# khusus untuk patch, jadi boleh tidak ada
# menggunakan "kosong" dan -9999 supaya bisa membedakan apakah tdk diupdate ("kosong") atau mau
# diupdate dengan dengan None atau 0


class FAQPatch(BaseModel):
    pertanyaan: str | None = None
    jawaban: str | None = None


@app.delete("/delete_faq/{id}")
def delete_faq(id: int):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("SELECT * FROM faq WHERE id = ?", (id,))
        existing_item = cur.fetchone()
    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Terjadi exception: {}".format(str(e)))

    if existing_item:
        try:
            cur.execute("DELETE FROM faq WHERE id = ?", (id,))
            con.commit()
        except Exception as e:
            raise HTTPException(
                status_code=500, detail="Terjadi exception: {}".format(str(e)))
    else:
        raise HTTPException(status_code=404, detail="Item Not Found")

    con.close()
    return {"status": "ok"}


# Konfigurasi JWT
SECRET_KEY = "secret"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/token")


# Fungsi untuk membuat access token
def create_access_token(data: dict, expires_delta: timedelta):
    to_encode = data.copy()
    expire = datetime.utcnow() + expires_delta
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


# Fungsi untuk memverifikasi access token
def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("sub")
        if email is None:
            raise HTTPException(
                status_code=401, detail="Invalid authentication credentials")
    except JWTError:
        raise HTTPException(
            status_code=401, detail="Invalid authentication credentials")

    user = get_user_db(email)
    if user is None:
        raise HTTPException(
            status_code=401, detail="Invalid authentication credentials")

    return user


# Fungsi untuk membuat pengguna baru di database
def create_user_db(username: str, email: str, password: str):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute(
            "INSERT INTO akun (username, email, password) VALUES (?, ?, ?)",
            (username, email, password)
        )
        con.commit()
    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Failed to create user: {}".format(str(e)))
    finally:
        con.close()


# Fungsi untuk mendapatkan pengguna dari database berdasarkan email
def get_user_db(email: str):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        cur.execute("SELECT * FROM akun WHERE email=?", (email,))
        user = cur.fetchone()
        if user:
            user_dict = {
                "username": user[1],
                "email": user[2],
                "password": user[3],
                "token": user[4]
            }
            return user_dict
        else:
            return None
    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Failed to get user: {}".format(str(e)))
    finally:
        con.close()


# Fungsi untuk membuat pengguna baru
def create_user(email: str, password: str, full_name: str):
    if get_user_db(email):
        raise HTTPException(status_code=400, detail="Email already registered")

    user = {
        "email": email,
        "password": password,
        "full_name": full_name,
    }

    create_user_db(full_name, email, password)

    return user


# Endpoint untuk mendapatkan token
@app.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = get_user_db(form_data.username)
    if not user or form_data.password != user["password"]:
        raise HTTPException(
            status_code=400, detail="Incorrect email or password")

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user["email"]}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}


# Endpoint yang membutuhkan autentikasi
@app.get("/protected")
async def protected_route(current_user: dict = Depends(get_current_user)):
    if current_user:
        return {"message": f"Hai, {current_user['full_name']}!"}
    else:
        raise HTTPException(
            status_code=401, detail="Invalid authentication credentials")


@app.get("/user")
async def get_user_data(current_user: dict = Depends(get_current_user)):
    if current_user:
        return current_user
    else:
        raise HTTPException(
            status_code=401, detail="Invalid authentication credentials")

# Endpoint untuk mendaftarkan pengguna baru


@app.post("/register")
async def register(email: str = Form(...), password: str = Form(...), full_name: str = Form(...)):
    user = create_user(email, password, full_name)

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user["email"]}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}


@app.post("/logout")
async def logout(response: Response, token: str = Cookie(None)):
    response.delete_cookie("token")
    return {"message": "Logged out successfully"}


@app.get("/init_pinjaman/")
def init_pinjaman():
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        # Buat tabel pinjaman
        create_table = """CREATE TABLE IF NOT EXISTS pinjaman (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            location TEXT NOT NULL,
            plafond TEXT NOT NULL,
            bagi_hasil_persen TEXT NOT NULL,
            tenor TEXT NOT NULL,
            pendanaan_ke TEXT NOT NULL,
            penghasilan_per_bulan FLOAT NOT NULL,
            pekerjaan TEXT NOT NULL,
            sektor TEXT NOT NULL,
            bagi_hasil_jmlh FLOAT NOT NULL,
            jenis_angsuran TEXT NOT NULL,
            jumlah_angsuran FLOAT NOT NULL,
            akad TEXT NOT NULL,
            status TEXT NOT NULL
        )"""
        cur.execute(create_table)

        # Insert data pinjaman ke dalam tabel
        data = {
            'name': 'Peternak 1',
            'description': 'Peternak Ayam',
            'location': 'Bandung, Jawa Barat',
            'plafond': 'Rp. 4.000.000',
            'bagi_hasil_persen': '12%',
            'tenor': '50 Minggu',
            'pendanaan_ke': '1',
            'penghasilan_per_bulan': 4500000,
            'pekerjaan': 'peternak lele',
            'sektor': 'peternakan',
            'bagi_hasil_jmlh': 500000,
            'jenis_angsuran': 'mingguan',
            'jumlah_angsuran': 100000,
            'akad': 'Perjanjian Pendanaan',
            'status': 'Aktif'
        }
        insert_query = """INSERT INTO pinjaman (
            name,
            description,
            location,
            plafond,
            bagi_hasil_persen,
            tenor,
            pendanaan_ke,
            penghasilan_per_bulan,
            pekerjaan,
            sektor,
            bagi_hasil_jmlh,
            jenis_angsuran,
            jumlah_angsuran,
            akad,
            status
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"""
        cur.execute(insert_query, (
            data['name'],
            data['description'],
            data['location'],
            data['plafond'],
            data['bagi_hasil_persen'],
            data['tenor'],
            data['pendanaan_ke'],
            data['penghasilan_per_bulan'],
            data['pekerjaan'],
            data['sektor'],
            data['bagi_hasil_jmlh'],
            data['jenis_angsuran'],
            data['jumlah_angsuran'],
            data['akad'],
            data['status']
        ))
        con.commit()

    except Exception as e:
        return {"status": "Terjadi error", "error_message": str(e)}

    finally:
        con.close()

    return {"status": "OK, tabel pinjaman berhasil diinisialisasi"}


@app.get("/tampil_semua_pinjaman/")
def tampil_semua_pinjaman():
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        pinjaman_data = []
        for row in cur.execute("SELECT * FROM pinjaman"):
            pinjaman = {
                'id': row[0],
                'name': row[1],
                'description': row[2],
                'location': row[3],
                'plafond': row[4],
                'bagi_hasil_persen': row[5],
                'tenor': row[6],
                'pendanaan_ke': row[7],
                'penghasilan_per_bulan': row[8],
                'pekerjaan': row[9],
                'sektor': row[10],
                'bagi_hasil_jmlh': row[11],
                'jenis_angsuran': row[12],
                'jumlah_angsuran': row[13],
                'akad': row[14],
                'status': row[15]
            }
            pinjaman_data.append(pinjaman)
    except:
        return {"status": "Terjadi error"}
    finally:
        con.close()
    return {"data": pinjaman_data}


@app.put("/update_status_pinjaman/{pinjaman_id}")
def update_status_pinjaman(pinjaman_id: int):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Perbarui status pinjaman menjadi "didanai"
        cur.execute(
            "UPDATE pinjaman SET status = 'didanai' WHERE id = ?", (pinjaman_id,))
        con.commit()

        # Cek apakah ada baris yang terpengaruh oleh perubahan data
        if cur.rowcount > 0:
            return {"status": "Sukses", "message": "Status pinjaman berhasil diperbarui"}
        else:
            return {"status": "Gagal", "message": "Tidak ditemukan pinjaman dengan ID tersebut"}
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()


@app.get("/tampil_semua_pinjaman_didanai/")
def tampil_semua_pinjaman():
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        pinjaman_data = []
        for row in cur.execute("SELECT * FROM pinjaman WHERE status = 'didanai'"):
            pinjaman = {
                'id': row[0],
                'name': row[1],
                'description': row[2],
                'location': row[3],
                'plafond': row[4],
                'bagi_hasil_persen': row[5],
                'tenor': row[6],
                'pendanaan_ke': row[7],
                'penghasilan_per_bulan': row[8],
                'pekerjaan': row[9],
                'sektor': row[10],
                'bagi_hasil_jmlh': row[11],
                'jenis_angsuran': row[12],
                'jumlah_angsuran': row[13],
                'akad': row[14],
                'status': row[15]
            }
            pinjaman_data.append(pinjaman)
    except:
        return {"status": "Terjadi error"}
    finally:
        con.close()
    return {"data": pinjaman_data}
