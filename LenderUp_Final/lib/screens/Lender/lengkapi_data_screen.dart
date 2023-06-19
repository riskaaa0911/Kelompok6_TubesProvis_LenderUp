import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LengkapiDataPage extends StatefulWidget {
  final String accessToken;
  const LengkapiDataPage({Key? key, required this.accessToken});

  @override
  State<LengkapiDataPage> createState() => _LengkapiDataPageState();
}

class _LengkapiDataPageState extends State<LengkapiDataPage> {
  Map<String, dynamic>? _userData;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = Uri.parse('http://localhost:8000/user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      setState(() {
        _userData = userData;
      });
      print(userData); // Mencetak data pengguna ke konsol
    } else {
      // Handle error response
    }
  }

  Future<void> _Verifikasi() async {
    final url =
        Uri.parse('http://localhost:8000/verifikasi_akun/${_userData?["ID"]}');
    final response = await http.put(
      url,
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      body: {
        'no_tlp': phoneNumberController.text,
        'nik': nikController.text,
        'nama_bank': bankNameController.text,
        'no_rekening': accountNumberController.text,
        'atas_nama_rekening': accountNameController.text,
        'penghasilan_per_bulan': incomeController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
      final responseData = jsonDecode(response.body);
      print(responseData); // Mencetak respons dari server ke konsol
    } else {
      // Handle error response
      print('Gagal memperbarui data akun');
    }
  }

  // text editing controllers
  final phoneNumberController = TextEditingController();
  final nikController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "LENGKAPI DATA"),
      backgroundColor: const Color(0xFF1D3557),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Masuk
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Lengkapi Data Anda Untuk mendapatkan akun Borrower, Lender, serta membuka fitur dompet.',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Additional text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Silakan isi semua informasi yang diperlukan untuk memastikan keamanan akun Anda.',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // List with checkmarks
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nomor Telepon
                      reusableTextField('Masukkan nomor telepon', false,
                          phoneNumberController),
                      const SizedBox(height: 10),
                      // NIK
                      reusableTextField('Masukkan NIK', false, nikController),
                      const SizedBox(height: 10),
                      // Nama Bank
                      reusableTextField(
                          'Masukkan nama Bank', false, bankNameController),
                      const SizedBox(height: 10),
                      // Nomor Rekening
                      reusableTextField('Masukkan nomor rekening', false,
                          accountNumberController),
                      const SizedBox(height: 10),
                      // Atas Nama Rekening
                      reusableTextField('Masukkan atas nama rekening', false,
                          accountNameController),
                      const SizedBox(height: 10),
                      // Pendapatan per Bulan
                      reusableTextField('Masukkan pendapatan per bulan', false,
                          incomeController),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            _Verifikasi();
                          },
                          style: ElevatedButton.styleFrom(
                            // Atur warna latar belakang tombol
                            primary: Color(0xFFFFB703),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                15, // Atur radius sudut yang lebih besar
                              ),
                            ),
                          ),
                          child: Text(
                            "Kirim",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1d3557),
                              ),
                            ),
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
      ),
    );
  }
}
