# conda activate webservicep2plending
# uvicorn main:app --reload
import requests
from typing import List
from fastapi import FastAPI
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
from datetime import date
from datetime import date
from dateutil.relativedelta import relativedelta
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
DB_NAME = "lander_up.db"
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


class Akun(BaseModel):
    username: str
    email: str
    password: str


# status code 201 standard return creation
# return objek yang baru dicreate (response_model tipenya Mhs)
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
                "ID": user[0],
                "username": user[1],
                "email": user[2],
                "password": user[3],
                "no_tlp": user[4],
                "nik": user[5],
                "nama_bank": user[6],
                "no_rekening": user[7],
                "atas_nama_rekening": user[8],
                "penghasilan_per_bulan": user[9],
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


@app.put("/verifikasi_akun/{akun_id}")
def update_akun(akun_id: int, no_tlp: str = Form(...), nik: str = Form(...), nama_bank: str = Form(...), no_rekening: str = Form(...), atas_nama_rekening: str = Form(...), penghasilan_per_bulan: float = Form(...)):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah akun dengan ID yang diberikan ada dalam database
        cur.execute("SELECT * FROM akun WHERE id = ?", (akun_id,))
        akun = cur.fetchone()
        if akun is None:
            return {"status": "Gagal", "message": "Tidak ditemukan akun dengan ID tersebut"}

        # Buat daftar kolom yang akan diupdate
        update_cols = []
        if no_tlp is not None:
            update_cols.append(("no_tlp", no_tlp))
        if nik is not None:
            update_cols.append(("nik", nik))
        if nama_bank is not None:
            update_cols.append(("nama_bank", nama_bank))
        if no_rekening is not None:
            update_cols.append(("no_rekening", no_rekening))
        if atas_nama_rekening is not None:
            update_cols.append(("atas_nama_rekening", atas_nama_rekening))
        if penghasilan_per_bulan is not None:
            update_cols.append(
                ("penghasilan_per_bulan", penghasilan_per_bulan))

        # Perbarui kolom-kolom pada akun
        if len(update_cols) > 0:
            update_query = "UPDATE akun SET " + \
                ", ".join([f"{col} = ?" for col, _ in update_cols]
                          ) + " WHERE id = ?"
            update_values = [value for _, value in update_cols] + [akun_id]
            cur.execute(update_query, update_values)
            saldo = 0
            # Add code to insert data into the lender table using the account ID
            cur.execute("INSERT INTO dompet (id_akun, saldo) VALUES (?,?)",
                        (akun_id, saldo))
            # Add code to insert data into the lender table using the account ID
            cur.execute("INSERT INTO lender (id_akun) VALUES (?)",
                        (akun_id,))

            # Calculate credit score based on income
            if penghasilan_per_bulan is not None:
                penghasilan = float(penghasilan_per_bulan)
                if penghasilan > 20000000:
                    skor_kredit = "A"
                elif penghasilan > 15000000:
                    skor_kredit = "B"
                elif penghasilan > 10000000:
                    skor_kredit = "C"
                elif penghasilan > 5000000:
                    skor_kredit = "D"
                elif penghasilan > 3000000:
                    skor_kredit = "E"
                else:
                    skor_kredit = "F"
            else:
                skor_kredit = "?"  # Handle the case when income is not available

            # Update the credit score in the database
            cur.execute(
                "INSERT INTO borrower (id_akun, skor_kredit) VALUES (?,?)", (akun_id, skor_kredit))

            con.commit()

        # Cek apakah ada baris yang terpengaruh oleh perubahan data
        if cur.rowcount > 0:
            return {"status": "Sukses", "message": "Data akun berhasil diperbarui"}
        else:
            return {"status": "Gagal", "message": "Tidak ada perubahan data akun"}
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()


@app.get("/borrower/{id_akun}")
def get_borrower_by_id_akun(id_akun: int):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah ada record borrower dengan id_akun yang diberikan
        cur.execute(
            "SELECT id_borrower, id_akun, skor_kredit FROM borrower WHERE id_akun = ?", (id_akun,))
        borrower = cur.fetchone()

        if borrower is not None:
            # Mengembalikan data borrower jika ditemukan
            return {
                "status": "Sukses",
                "data": {
                    "id_borrower": borrower[0],
                    "id_akun": borrower[1],
                    "skor_kredit": borrower[2]
                }
            }
        else:
            return {"status": "Gagal", "message": "Tidak ditemukan record borrower dengan id_akun tersebut"}

    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}

    finally:
        con.close()


@app.get("/lender/{id_akun}")
def get_lender_by_id_akun(id_akun: int):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah ada record lender dengan id_akun yang diberikan
        cur.execute(
            "SELECT id_lender, id_akun FROM lender WHERE id_akun = ?", (id_akun,))
        lender = cur.fetchone()

        if lender is not None:
            # Mengembalikan data lender jika ditemukan
            return {
                "status": "Sukses",
                "data": {
                    "id_lender": lender[0],
                    "id_akun": lender[1],
                }
            }
        else:
            return {"status": "Gagal", "message": "Tidak ditemukan record lender dengan id_akun tersebut"}

    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}

    finally:
        con.close()


@app.get("/dompet/{id_akun}")
def get_dompet_by_id_akun(id_akun: int):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah ada record dompet dengan id_akun yang diberikan
        cur.execute(
            "SELECT id_dompet, id_akun, saldo FROM dompet WHERE id_akun = ?", (id_akun,))
        dompet = cur.fetchone()

        if dompet is not None:
            # Mengembalikan data dompet jika ditemukan
            return {
                "status": "Sukses",
                "data": {
                    "id_dompet": dompet[0],
                    "id_akun": dompet[1],
                    "saldo": dompet[2]
                }
            }
        else:
            return {"status": "Gagal", "message": "Tidak ditemukan record dompet dengan id_akun tersebut"}

    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}

    finally:
        con.close()


class DompetPatch(BaseModel):
    tambah_saldo: int | None = 0


@app.patch("/top_up_dompet/{id_dompet}", response_model=DompetPatch)
def update_mhs_patch(response: Response, id_dompet: int, d: DompetPatch):
    try:
        print(str(d))
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah ada record dompet dengan id_dompet yang diberikan
        cur.execute(
            "SELECT id_dompet, saldo FROM dompet WHERE id_dompet = ?", (id_dompet,))
        dompet = cur.fetchone()

        if dompet:  # Jika data dompet ditemukan
            tambahan_saldo = d.tambah_saldo
            saldo_sekarang = dompet[1]
            saldo_baru = saldo_sekarang + tambahan_saldo

            # Update saldo dompet dengan saldo baru
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?", (saldo_baru, id_dompet))
            con.commit()

            response.headers["location"] = "/dompet/{}".format(id_dompet)
            return d
        else:  # Jika data dompet tidak ditemukan
            raise HTTPException(
                status_code=404, detail="Dompet dengan id_dompet tersebut tidak ditemukan")

    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Terjadi exception: {}".format(str(e)))

    finally:
        con.close()


@app.patch("/with_draw_dompet/{id_dompet}", response_model=DompetPatch)
def with_draw_dompet(response: Response, id_dompet: int, d: DompetPatch):
    try:
        print(str(d))
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Cek apakah ada record dompet dengan id_dompet yang diberikan
        cur.execute(
            "SELECT id_dompet, saldo FROM dompet WHERE id_dompet = ?", (id_dompet,))
        dompet = cur.fetchone()

        if dompet:  # Jika data dompet ditemukan
            tambahan_saldo = d.tambah_saldo
            saldo_sekarang = dompet[1]
            saldo_baru = saldo_sekarang - tambahan_saldo

            # Update saldo dompet dengan saldo baru
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?", (saldo_baru, id_dompet))
            con.commit()

            response.headers["location"] = "/dompet/{}".format(id_dompet)
            return d
        else:  # Jika data dompet tidak ditemukan
            raise HTTPException(
                status_code=404, detail="Dompet dengan id_dompet tersebut tidak ditemukan")

    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Terjadi exception: {}".format(str(e)))

    finally:
        con.close()


class PinjamanCreate(BaseModel):
    name: str
    description: str
    location: str
    penghasilan_per_bulan: float
    sektor: str
    plafond: int
    bagi_hasil_persen: int
    tenor: int
    akad: str
    id_borrower: int
    nominal_pinjaman: float


@app.post("/pinjaman_pengajuan/")
def create_pinjaman(pinjaman: PinjamanCreate):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        bagi_hasil_jmlh = pinjaman.bagi_hasil_persen/100*pinjaman.nominal_pinjaman
        jumlah_angsuran = (pinjaman.nominal_pinjaman +
                           bagi_hasil_jmlh)/pinjaman.tenor
        status = "Belum Didanai"
        nominal_dilunasi = 0
        # Insert record ke tabel pinjaman
        cur.execute(
            """
            INSERT INTO pinjaman (
                name, description, location, penghasilan_per_bulan, sektor, plafond,
                bagi_hasil_jmlh, bagi_hasil_persen, tenor, jumlah_angsuran, akad,
                status, nominal_dilunasi, id_borrower, nominal_pinjaman
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                pinjaman.name, pinjaman.description, pinjaman.location,
                pinjaman.penghasilan_per_bulan, pinjaman.sektor, pinjaman.plafond,
                bagi_hasil_jmlh, pinjaman.bagi_hasil_persen, pinjaman.tenor,
                jumlah_angsuran, pinjaman.akad, status,
                nominal_dilunasi, pinjaman.id_borrower, pinjaman.nominal_pinjaman
            )
        )
        con.commit()

        # Mendapatkan ID record yang baru ditambahkan
        pinjaman_id = cur.lastrowid

        response = {"id": pinjaman_id, **pinjaman.dict()}
        return response

    except Exception as e:
        raise HTTPException(
            status_code=500, detail="Terjadi exception: {}".format(str(e)))

    finally:
        con.close()


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
                'penghasilan_per_bulan': row[4],
                'sektor': row[5],
                'plafond': row[6],
                'bagi_hasil_jmlh': row[7],
                'bagi_hasil_persen': row[8],
                'tenor': row[9],
                'jumlah_angsuran': row[10],
                'akad': row[11],
                'status': row[12],
                'nominal_dilunasi': row[13],
                'id_borrower': row[14],
                'nominal_pinjaman': row[15],
            }
            pinjaman_data.append(pinjaman)
    except:
        return {"status": "Terjadi error"}
    finally:
        con.close()
    return {"data": pinjaman_data}


class Transaksi(BaseModel):
    id_dompet: Optional[int]
    id_borrower: Optional[int]
    id_lender: Optional[int]
    jumlah: int
    tanggal: Optional[date]
    jenis_transaksi: str

# Rest of the code remains the same...


@app.post("/tambah_transaksi/", response_model=Transaksi, status_code=201)
def tambah_transaksi(transaksi: Transaksi, response: Response, request: Request):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        cur.execute(
            """INSERT INTO transaksi (id_dompet, id_borrower, id_lender, jumlah, tanggal, jenis_transaksi) 
            VALUES (?, ?, ?, ?, ?, ?)""",
            (
                transaksi.id_dompet,
                transaksi.id_borrower,
                transaksi.id_lender,
                transaksi.jumlah,
                transaksi.tanggal,
                transaksi.jenis_transaksi,
            )
        )
        con.commit()
    except Exception as e:
        print("Terjadi error:", str(e))
        return {"status": "Terjadi error"}
    finally:
        con.close()

    return transaksi


@app.get("/tampil_semua_transaksi/{id_dompet}")
def tampil_semua_transaksi(id_dompet: int):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        transaksi_data = []

        cur.execute("SELECT d.id_dompet, l.id_lender, b.id_borrower FROM dompet AS d JOIN akun AS a ON d.id_akun = a.ID LEFT JOIN lender AS l ON a.ID = l.id_akun LEFT JOIN borrower AS b ON a.ID = b.id_akun WHERE d.id_dompet = ?", (id_dompet,))
        id_lender_borrower = cur.fetchone()

        if id_lender_borrower:
            id_lender = id_lender_borrower[1]
            id_borrower = id_lender_borrower[2]

            cur.execute("SELECT * FROM transaksi WHERE id_dompet=? OR id_lender=? OR id_borrower=? ORDER BY id_transaksi DESC",
                        (id_dompet, id_lender, id_borrower))

            for row in cur.fetchall():
                transaksi = {
                    'id_transaksi': row[0],
                    'id_dompet': row[1],
                    'id_borrower': row[2],
                    'id_lender': row[3],
                    'jumlah': row[4],
                    'tanggal': row[5],
                    'jenis_transaksi': row[6],
                }
                transaksi_data.append(transaksi)

    except:
        return {"status": "Terjadi error"}
    finally:
        con.close()

    return {"data": transaksi_data}


class Invest(BaseModel):
    id_lender: int
    id_borrower: int
    tenor: int
    nominal_pinjaman: float
    tanggal_didanai: Optional[date]


@app.put("/update_status_pinjaman/{pinjaman_id}")
def update_status_pinjaman(pinjaman_id: int, response: Response, request: Request, i: Invest):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Perbarui status pinjaman menjadi "didanai" dan set nilai tanggal_didanai
        cur.execute(
            "UPDATE pinjaman SET status = 'didanai', tanggal_didanai = ?, id_lender=? , pembayaran_ke=0 WHERE id = ?",
            (i.tanggal_didanai, i.id_lender, pinjaman_id))

        # Perbarui nilai tanggal_jatuh_tempo jika ada
        if i.tanggal_didanai and i.tenor:
            tanggal_jatuh_tempo = i.tanggal_didanai + \
                relativedelta(months=i.tenor)
            cur.execute(
                "UPDATE pinjaman SET tanggal_jatuh_tempo = ? WHERE id = ?",
                (tanggal_jatuh_tempo, pinjaman_id))

        # Retrieve saldo_dompet from the dompet table based on id_borrower
        cur.execute(
            "SELECT dompet.saldo, dompet.id_dompet "
            "FROM dompet "
            "JOIN borrower ON dompet.id_akun = borrower.id_akun "
            "WHERE borrower.id_borrower = ?",
            (i.id_borrower,),
        )
        dompet = cur.fetchone()

        if dompet:
            saldo = dompet[0]
            id_dompet = dompet[1]

            # Deduct the nominal_pinjaman from the saldo
            saldo += i.nominal_pinjaman

            # Update the saldo in the dompet table
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?",
                (saldo, id_dompet),
            )
        cur.execute(
            "SELECT dompet.saldo, dompet.id_dompet "
            "FROM dompet "
            "JOIN lender ON dompet.id_akun = lender.id_akun "
            "WHERE lender.id_lender = ?",
            (i.id_lender,),
        )
        dompet = cur.fetchone()

        if dompet:
            saldo = dompet[0]
            id_dompet = dompet[1]

            # Deduct the nominal_pinjaman from the saldo
            saldo -= i.nominal_pinjaman

            # Update the saldo in the dompet table
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?",
                (saldo, id_dompet),
            )
        # Call tambah_transaksi to add a new transaction
        new_transaksi = Transaksi(
            id_dompet=id_dompet,
            id_borrower=i.id_borrower,
            id_lender=i.id_lender,
            jumlah=i.nominal_pinjaman,
            tanggal=i.tanggal_didanai,
            jenis_transaksi="Pemberian Pinjaman",
        )
        tambah_transaksi(new_transaksi, response, request)
        con.commit()

        transaksi_data = {
            "id_dompet": 0,
            "id_borrower": i.id_borrower,
            "id_lender": i.id_lender,
            "jumlah": i.nominal_pinjaman,
            "tanggal": i.tanggal_didanai,
            "jenis_transaksi": "Pemberian Pinjaman",
        }

        # Cek apakah ada baris yang terpengaruh oleh perubahan data
        if cur.rowcount > 0:
            return {"status": "Sukses", "message": "Status pinjaman berhasil diperbarui", "transaksi_data": transaksi_data}
        else:
            return {"status": "Gagal", "message": "Tidak ditemukan pinjaman dengan ID tersebut"}
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()


@app.get("/tampil_semua_pinjaman_didanai/{id_lender}")
def tampil_semua_pinjaman(id_lender: int):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        pinjaman_data = []
        for row in cur.execute("SELECT * FROM pinjaman WHERE (status = 'didanai' OR status = 'lunas') AND id_lender = ?", (id_lender,)):
            pinjaman = {
                "id": row[0],
                "name": row[1],
                "description": row[2],
                "location": row[3],
                "penghasilan_per_bulan": row[4],
                "sektor": row[5],
                "plafond": row[6],
                "bagi_hasil_jmlh": row[7],
                "bagi_hasil_persen": row[8],
                "tenor": row[9],
                "jumlah_angsuran": row[10],
                "akad": row[11],
                "status": row[12],
                "nominal_dilunasi": row[13],
                "id_borrower": row[14],
                "nominal_pinjaman": row[15],
                "pembayaran_ke": row[16],
            }
            pinjaman_data.append(pinjaman)
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()
    return {"data": pinjaman_data}


@app.get("/tampil_semua_pinjaman_borrower/{id_borrower}")
def tampil_semua_pinjaman(id_borrower: int):
    try:
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        pinjaman_data = []
        for row in cur.execute(
            "SELECT pinjaman.*, akun.username "
            "FROM pinjaman "
            "JOIN lender ON pinjaman.id_lender = lender.id_lender "
            "JOIN akun ON lender.id_akun = akun.ID "
            "WHERE pinjaman.id_borrower = ?",
            (id_borrower,),
        ):
            pinjaman = {
                "id": row[0],
                "name": row[1],
                "description": row[2],
                "location": row[3],
                "penghasilan_per_bulan": row[4],
                "sektor": row[5],
                "plafond": row[6],
                "bagi_hasil_jmlh": row[7],
                "bagi_hasil_persen": row[8],
                "tenor": row[9],
                "jumlah_angsuran": row[10],
                "akad": row[11],
                "status": row[12],
                "nominal_dilunasi": row[13],
                "id_borrower": row[14],
                "nominal_pinjaman": row[15],
                "id_lender": row[16],
                "tanggal_didanai": row[17],
                "tanggal_jatuh_tempo": row[18],
                "pembayaran_ke": row[19],
                "username": row[20],
            }
            pinjaman_data.append(pinjaman)
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()
    return {"data": pinjaman_data}


class Bayar(BaseModel):
    id_lender: int
    id_borrower: int
    jumlah_angsuran: float
    tanggal_bayar: Optional[date]


@app.put("/bayar_pinjaman/{pinjaman_id}")
def bayar_pinjaman(pinjaman_id: int, response: Response, request: Request, i: Bayar):
    try:
        DB_NAME = "lander_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()

        # Retrieve tenor from the pinjaman table based on pinjaman_id
        cur.execute(
            "SELECT tenor FROM pinjaman WHERE id = ?",
            (pinjaman_id,),
        )
        tenor = cur.fetchone()[0]

        # Perbarui nominal dilunasi dan pembayaran ke
        cur.execute(
            "UPDATE pinjaman SET nominal_dilunasi = nominal_dilunasi + ?, pembayaran_ke = pembayaran_ke + 1 WHERE id = ?",
            (i.jumlah_angsuran, pinjaman_id),
        )

        # Check if pembayaran_ke is equal to tenor, update the status to "lunas"
        cur.execute(
            "SELECT pembayaran_ke FROM pinjaman WHERE id = ?",
            (pinjaman_id,),
        )
        pembayaran_ke = cur.fetchone()[0]

        if pembayaran_ke == tenor:
            cur.execute(
                "UPDATE pinjaman SET status = 'lunas' WHERE id = ?",
                (pinjaman_id,),
            )

        # Retrieve saldo_dompet from the dompet table based on id_borrower
        cur.execute(
            "SELECT dompet.saldo, dompet.id_dompet "
            "FROM dompet "
            "JOIN borrower ON dompet.id_akun = borrower.id_akun "
            "WHERE borrower.id_borrower = ?",
            (i.id_borrower,),
        )
        dompet = cur.fetchone()

        if dompet:
            saldo = dompet[0]
            id_dompet = dompet[1]

            # Deduct the jumlah_angsuran from the saldo
            saldo -= i.jumlah_angsuran

            # Update the saldo in the dompet table
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?",
                (saldo, id_dompet),
            )

        # Retrieve saldo_dompet from the dompet table based on id_lender
        cur.execute(
            "SELECT dompet.saldo, dompet.id_dompet "
            "FROM dompet "
            "JOIN lender ON dompet.id_akun = lender.id_akun "
            "WHERE lender.id_lender = ?",
            (i.id_lender,),
        )
        dompet = cur.fetchone()

        if dompet:
            saldo = dompet[0]
            id_dompet = dompet[1]

            # Add the jumlah_angsuran to the saldo
            saldo += i.jumlah_angsuran

            # Update the saldo in the dompet table
            cur.execute(
                "UPDATE dompet SET saldo = ? WHERE id_dompet = ?",
                (saldo, id_dompet),
            )

        con.commit()

        transaksi_data = {
            "id_dompet": 0,
            "id_borrower": i.id_borrower,
            "id_lender": i.id_lender,
            "jumlah": i.jumlah_angsuran,
            "tanggal": i.tanggal_bayar,
            "jenis_transaksi": "Bayar Cicilan",
        }

        # Cek apakah ada baris yang terpengaruh oleh perubahan data
        if cur.rowcount > 0:
            return {
                "status": "Sukses",
                "message": "Status pinjaman berhasil diperbarui",
                "transaksi_data": transaksi_data,
            }
        else:
            return {
                "status": "Gagal",
                "message": "Tidak ditemukan pinjaman dengan ID tersebut",
            }
    except Exception as e:
        return {"status": "Terjadi error", "message": str(e)}
    finally:
        con.close()
