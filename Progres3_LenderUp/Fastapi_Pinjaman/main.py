from typing import Union
from fastapi import FastAPI,Response,Request,HTTPException
from fastapi.middleware.cors import CORSMiddleware
import sqlite3

app = FastAPI()

app.add_middleware(
 CORSMiddleware,
 allow_origins=["*"],
 allow_credentials=True,
 allow_methods=["*"],
 allow_headers=["*"],
)

@app.get("/tampilkan_transaksi_borrower2/{borrower_id}")
def tampil_transaksi_borrower(borrower_id):
    try:
        DB_NAME = "db_lender_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        data = []
        for row in cur.execute("SELECT * FROM transaksi_t WHERE jenis_transaksi='Pelunasan' AND borrower_id=?", (borrower_id,)):
            transaksi_id = row[0]
            borrower_id = row[1]
            lender_id = row[2]
            jumlah = row[3]
            tanggal_transaksi = row[4]
            jenis_transaksi = row[5]
            
            data.append({
                "transaksi_id": transaksi_id,
                "borrower_id": borrower_id,
                "lender_id": lender_id,
                "jumlah" : jumlah,
                "tanggal_transaksi" :  tanggal_transaksi,
                "jenis_transaksi" : jenis_transaksi,
                
            })
        if len(data) == 0:
            return {"status": "Data not found for borrower_id: " + borrower_id}
    except:
        return {"status": "An error occurred"}
    finally:
        con.close()
    return {"data": data}

@app.get("/tampilkan_pinjaman_selesai/{borrower_id}")
def tampil_pinjaman_selesai(borrower_id):
    try:
        DB_NAME = "db_lender_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        data = []
        for row in cur.execute("SELECT * FROM pinjaman_t WHERE pinjaman_status='selesai' AND borrower_id=?", (borrower_id,)):
            pinjaman_id = row[0]
            borrower_id = row[1]
            plafond = row[2]
            bagi_hasil = row[3]
            tenor = row[4]
            pinjaman_status = row[5]
            pinjaman_progres = row[6]
            tanggal_lunas = row[7]
            nama_umkm = row[8]
            sektor_umkm = row[9]
            lama_umkm = row[10]
            keuntungan_umkm = row[11]
            alamat_umkm = row[12]
            tanda_tangan = row[13]
            
            
            data.append({
                "pinjaman_id": pinjaman_id,
                "borrower_id": borrower_id,
                "plafond" : plafond,
                "bagi_hasil" :bagi_hasil,
                "tenor" : tenor,
                "pinjaman_status" : pinjaman_status,
                "pinjaman_progres" : pinjaman_progres,
                "tanggal_lunas" :tanggal_lunas,
                "nama_umkm" : nama_umkm,
                "sektor_umkm" :sektor_umkm,
                "lama_umkm" : lama_umkm,
                "keuntungan_umkm" : keuntungan_umkm,
                "alamat_umkm" : alamat_umkm,
                "tanda_tangan" : tanda_tangan,    
            })
        if len(data) == 0:
            return {"status": "Data not found for borrower_id: " + borrower_id}
    except:
        return {"status": "An error occurred"}
    finally:
        con.close()
    return {"data": data}

@app.get("/tampilkan_pinjaman_aktif/{borrower_id}")
def tampil_pinjaman_aktif(borrower_id):
    try:
        DB_NAME = "db_lender_up.db"
        con = sqlite3.connect(DB_NAME)
        cur = con.cursor()
        data = []
        for row in cur.execute("SELECT * FROM pinjaman_t WHERE pinjaman_status='aktif' AND borrower_id=?", (borrower_id,)):
            pinjaman_id = row[0]
            borrower_id = row[1]
            plafond = row[2]
            bagi_hasil = row[3]
            tenor = row[4]
            pinjaman_status = row[5]
            pinjaman_progres = row[6]
            tanggal_lunas = row[7]
            nama_umkm = row[8]
            sektor_umkm = row[9]
            lama_umkm = row[10]
            keuntungan_umkm = row[11]
            alamat_umkm = row[12]
            tanda_tangan = row[13]
            
            
            data.append({
                "pinjaman_id": pinjaman_id,
                "borrower_id": borrower_id,
                "plafond" : plafond,
                "bagi_hasil" :bagi_hasil,
                "tenor" : tenor,
                "pinjaman_status" : pinjaman_status,
                "pinjaman_progres" : pinjaman_progres,
                "tanggal_lunas" :tanggal_lunas,
                "nama_umkm" : nama_umkm,
                "sektor_umkm" :sektor_umkm,
                "lama_umkm" : lama_umkm,
                "keuntungan_umkm" : keuntungan_umkm,
                "alamat_umkm" : alamat_umkm,
                "tanda_tangan" : tanda_tangan,    
            })
        if len(data) == 0:
            return {"status": "Data not found for borrower_id: " + borrower_id}
    except:
        return {"status": "An error occurred"}
    finally:
        con.close()
    return {"data": data}

