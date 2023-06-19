import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<void> withdrawDompet(int idDompet, int tambahSaldo) async {
  final url = Uri.parse('http://localhost:8000/with_draw_dompet/$idDompet');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'tambah_saldo': tambahSaldo});

  final response = await http.patch(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Top up successful, handle the response if needed
    print('withdraw successful');
    tambah_transaksi_with_draw(idDompet, tambahSaldo, "Withdraw");
  } else {
    // withdraw failed, handle the error if needed
    print('withdraw failed: ${response.statusCode}');
  }
}

Future<void> tambah_transaksi_with_draw(
    int idDompet, int tambahSaldo, String jenis) async {
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final url = Uri.parse('http://localhost:8000/tambah_transaksi');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'id_dompet': idDompet,
    'id_borrower': null,
    'id_lender': null,
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

class WithDraw extends StatefulWidget {
  final int id_dompet;
  const WithDraw({Key? key, required this.id_dompet}) : super(key: key);

  @override
  WithDrawState createState() => WithDrawState();
}

class WithDrawState extends State<WithDraw> {
  TextEditingController _topUpController = TextEditingController();
  @override
  void dispose() {
    _topUpController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "Withdraw"),
      backgroundColor: const Color(0xFF1D3557),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('DOMPET',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tarik Dana',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Text('Biaya Transfer +Rp 2.900',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          reusableTextField(
              "Masukan Nominal Withdraw", false, _topUpController),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dana Tersedia',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Text('Rp 0',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Tarik',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xff1D3557),
                              fontSize: 15,
                              fontWeight: FontWeight.bold))),
                  onPressed: () {
                    String topUpAmount = _topUpController.text;
                    int tambahSaldo = int.tryParse(topUpAmount) ?? 0;

                    if (tambahSaldo > 0) {
                      withdrawDompet(widget.id_dompet, tambahSaldo);
                    } else {
                      // Handle invalid top-up amount
                      print('Invalid top-up amount');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB703),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 60.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Informasi Rekening Saya',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Text('Bank Mandiri',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pemilik Akun',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Text('Nama',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. Rekening',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Text('XXXXXXXXXXXXXX',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
