import sqlite3
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware 



app = FastAPI()

app.add_middleware(
 CORSMiddleware,
 allow_origins=["*"],
 allow_credentials=True,
 allow_methods=["*"],
 allow_headers=["*"],
)

@app.get("/get_wallet/{akun_id}")
def show_saldo(akun_id:int):
	con = None
	try:
		DB_NAME = "db_lender_up.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		get_wallet = """SELECT * FROM dompet_t WHERE akun_id = ?"""
		values = {"akun_id": akun_id}
		recs = []

		for row in cur.execute(get_wallet, (akun_id,)):
			recs.append(row)
	except Exception as e:
		return {"status": "terjadi error", "error": str(e)}
	finally:
		if con is not None:
			con.close()

	return {"data": recs}


@app.get("/get_transaction/{account_type}/{akun_id}")
def show_saldo(account_type: str, akun_id:int):
	con = None
	try:
		DB_NAME = "db_lender_up.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		recs = []
		if account_type == "lender":
			get_transaction = """SELECT * FROM transaksi_t WHERE lender_id = ? ORDER BY tanggal_transaksi DESC"""
			values = {"lender_id": akun_id}

		elif account_type == "borrower":
			get_transaction = """SELECT * FROM transaksi_t WHERE borrower_id = ? ORDER BY tanggal_transaksi DESC"""
			values = {"borrower_id": akun_id}
			
		

		for row in cur.execute(get_transaction, (akun_id,)):
			recs.append(row)

	except Exception as e:
		return {"status": "terjadi error", "error": str(e)}
	finally:
		if con is not None:
			con.close()

	return {"data": recs}


#IN PROGRESS VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

#class DompetPatch(BaseModel):
#	saldo: int | None = "kosong"


@app.get("/update_saldo/{borrower_id}/{lender_id}/{jenis_transaksi}/{jumlah}")
def update_saldo(borrower_id: int, lender_id: int, jenis_transaksi: str, jumlah: int):
	con = None
	try:
		DB_NAME = "db_lender_up.db"
		con = sqlite3.connect(DB_NAME)
		cur = con.cursor()
		cur.execute("""
						SELECT dompet_id, akun_id, saldo
						FROM dompet_t
						WHERE akun_id IN (
							SELECT akun_id
							FROM borrower_t
							WHERE borrower_id = ?
						);""",(borrower_id,))
		borrower_wallet = cur.fetchone()

		cur.execute("""
						SELECT dompet_id, akun_id, saldo
						FROM dompet_t
						WHERE akun_id IN (
							SELECT akun_id
							FROM lender_t
							WHERE lender_id = ?
						);""" ,(lender_id,))
		lender_wallet = cur.fetchone()


	except Exception as e:
		return {"status": "terjadi error", "error": str(e)}
	finally:
		if con is not None:
			con.close()

	return {"borrower_wallet": borrower_wallet, "lender_wallet": lender_wallet}