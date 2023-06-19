import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Map<String, dynamic> _transaksiData = {};
Future<void> updateStatusPinjaman(int pinjamanId, int idLender, int idBorrower,
    int tenor, double nominalPinjaman) async {
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  try {
    final response = await http.put(
      Uri.parse('http://localhost:8000/update_status_pinjaman/$pinjamanId'),
      body: jsonEncode({
        'id_lender': idLender,
        'id_borrower': idBorrower,
        'tenor': tenor,
        'nominal_pinjaman': nominalPinjaman,
        'tanggal_didanai': currentDate,
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

Widget buildSheetMendanai(Map<String, dynamic> data,
        Map<String, dynamic>? lenderData, Map<String, dynamic>? dompetData) =>
    Container(
        decoration: BoxDecoration(
            color: Color(0xffffb703),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        height: 450,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40, top: 30),
                  child: ClipOval(
                    child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          Text(data['description'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))),
                          Text(data['location'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))),
                        ])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text("Nominal Pinjaman",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xff1D3557),
                            fontSize: 8,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                    Container(
                      child: Text(
                        "Rp. ${NumberFormat('#,###').format(data['nominal_pinjaman'])}",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      // margin:
                      // EdgeInsets.only(left: 70, right: 70),
                      child: Text("Bagi Hasil",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xff1D3557),
                            fontSize: 8,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                    Container(
                      // margin:
                      // EdgeInsets.only(left: 70, right: 70),
                      child: Text("${data['bagi_hasil_persen'].toString()}%",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text("Tenor",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xff1D3557),
                            fontSize: 8,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                    Container(
                      child: Text("${data['tenor'].toString()} bulan",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saldo dompet anda akan berkurang Rp. ${NumberFormat('#,##0', 'id_ID').format(data['nominal_pinjaman'])}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0xff1d3557),
                          fontSize: 17,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Saldo dompet Rp. ${NumberFormat('#,##0', 'id_ID').format(dompetData?['data']['saldo'])}",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                    Text("Pastikan saldo dompet anda cukup",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 150,
              width: double.infinity,
              color: Color(0XFF1D3557),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pembayaran dari Mitra",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ))),
                              Text("Total Hasil",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ))),
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rp. ${NumberFormat('#,###').format(data['jumlah_angsuran'])}/bulan",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "Rp. ${NumberFormat('#,###').format(data['bagi_hasil_jmlh'])}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: (dompetData?['data']['saldo'] as int) >=
                            (data['nominal_pinjaman'] as int)
                        ? ElevatedButton(
                            onPressed: () {
                              updateStatusPinjaman(
                                  data['id'],
                                  lenderData?['data']['id_lender'],
                                  data['id_borrower'],
                                  data['tenor'],
                                  data['nominal_pinjaman']);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Color(0xffFFB703),
                            ),
                            child: Text(
                              'Beri Modal',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Color(0XFF1D3557),
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
                                      color: const Color.fromARGB(
                                          255, 252, 54, 54),
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
            )
          ],
        )));
