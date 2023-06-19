import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/reuseable_widgets/card_rekening.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

Future<void> topUpDompet(int idDompet, int tambahSaldo) async {
  final url = Uri.parse('http://localhost:8000/top_up_dompet/$idDompet');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'tambah_saldo': tambahSaldo});

  final response = await http.patch(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Top up successful, handle the response if needed
    print('Top up successful');
    tambah_transaksi_top_up(idDompet, tambahSaldo, "Top Up");
  } else {
    // Top up failed, handle the error if needed
    print('Top up failed: ${response.statusCode}');
  }
}

Future<void> tambah_transaksi_top_up(
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

class TopUp extends StatefulWidget {
  final int id_dompet;

  const TopUp({Key? key, required this.id_dompet}) : super(key: key);

  @override
  TopUpState createState() => TopUpState();
}

class TopUpState extends State<TopUp> {
  TextEditingController _topUpController = TextEditingController();

  @override
  void dispose() {
    _topUpController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "TOP UP"),
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
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Changed to MainAxisAlignment.start
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Up  :',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Text(
                    'Transfer via ATM atau Internet banking ke salah satu virtual akun berikut:',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700))),
              ],
            ),
          ),

          SizedBox(height: 20.0),
          // Generate cards using a loop
          for (int i = 0; i < 3; i++)
            getCardRekening('No. Virtual Account', 'XXXXXXXXXXXXXX'),

          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nominal Top Up:',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _topUpController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nominal top up',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String topUpAmount = _topUpController.text;
                    int tambahSaldo = int.tryParse(topUpAmount) ?? 0;

                    if (tambahSaldo > 0) {
                      topUpDompet(widget.id_dompet, tambahSaldo);
                    } else {
                      // Handle invalid top-up amount
                      print('Invalid top-up amount');
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange), // Set the background color
                  ),
                  child: Text(
                    'Top Up',
                    style: TextStyle(color: Colors.white), // Set the text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
