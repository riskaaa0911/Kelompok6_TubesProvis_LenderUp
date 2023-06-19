import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Map<String, dynamic> _transaksiData = {};
Future<void> barayPinjaman(int pinjamanId, int idLender, int idBorrower,
    double nominalPinjaman) async {
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  try {
    final response = await http.put(
      Uri.parse('http://localhost:8000/bayar_pinjaman/$pinjamanId'),
      body: jsonEncode({
        'id_lender': idLender,
        'id_borrower': idBorrower,
        'jumlah_angsuran': nominalPinjaman,
        'tanggal_bayar': currentDate,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      _transaksiData = data['transaksi_data'];
      tambah_transaksi(
          _transaksiData['id_borrower'],
          _transaksiData['id_lender'],
          _transaksiData['jumlah'],
          _transaksiData['jenis_transaksi']);
    } else {
      // Error handling jika responsenya bukan 200
      print('Gagal memperbarui status pinjaman');
    }
  } catch (e) {
    // Error handling jika terjadi kesalahan koneksi atau lainnya
    print('Terjadi kesalahan: $e');
  }
}

Future<void> tambah_transaksi(
    int id_borrower, int id_lender, int tambahSaldo, String jenis) async {
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final url = Uri.parse('http://localhost:8000/tambah_transaksi');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'id_dompet': null,
    'id_borrower': id_borrower,
    'id_lender': id_lender,
    'jumlah': tambahSaldo,
    'tanggal': currentDate,
    'jenis_transaksi': jenis,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 201) {
    // Top up successful, handle the response if needed
    final responseData = jsonDecode(response.body);
    print('Top up successful: $responseData');
  } else {
    // Top up failed, handle the error if needed
    print('Top up failed: ${response.statusCode}');
  }
}

Widget buildSheetBayar(context, Map<String, dynamic> data,
        Map<String, dynamic>? borrowerData, Map<String, dynamic>? dompetData) =>
    Container(
      decoration: BoxDecoration(
        color: Color(0xffffb703),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 600,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 25, top: 40),
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      data['description'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      data['location'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tanggal Jatuh Tempo",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "${data['tanggal_jatuh_tempo']}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: LinearProgressIndicator(
                      value: 50,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF1D3557)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detail Pinjaman',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plafond',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Rp ${data['plafond']}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pembayaran ke',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${data['pembayaran_ke']}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tenor',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${data['tenor']} Bulan',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bagi hasil',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Rp ${data['bagi_hasil_jmlh']}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jenis angsuran',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Bulanan',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jumlah angsuran',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Rp ${data['jumlah_angsuran']}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Akad',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${data['akad']}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pemberi Dana',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: Row(
              children: [
                CardPendana(data['username'], data['nominal_pinjaman']),
              ],
            ),
          ),
          Text(
            "Pembayaran Cicilan ke-${data['pembayaran_ke'] + 1} anda\nSaldo Anda Akan Berkurang Rp. ${NumberFormat('#,###').format(data['jumlah_angsuran'])}",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: (dompetData?['data']['saldo'] as int) >=
                    (data['jumlah_angsuran'] as int)
                ? ElevatedButton(
                    onPressed: () {
                      barayPinjaman(
                        data['id'],
                        data['id_lender'],
                        data['id_borrower'],
                        data['jumlah_angsuran'],
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Color.fromARGB(255, 1, 61, 110),
                    ),
                    child: Text(
                      'Bayar Cicilan',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white, // Set the color to white
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Saldo Kurang, silahkan Top up",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: const Color.fromARGB(255, 252, 54, 54),
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );

Widget CardPendana(String nama, num nominal) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Color.fromARGB(255, 1, 61, 110), // Set the card color to Royal Blue
    child: Container(
      width: 220,
      height: 80,
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "${nama}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          "Rp. ${nominal}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          // Handle onTap action
        },
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    ),
  );
}
