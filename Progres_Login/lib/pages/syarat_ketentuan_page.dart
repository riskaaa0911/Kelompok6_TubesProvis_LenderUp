import 'package:flutter/material.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/square_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class SyaratKetentuanPage extends StatelessWidget {
  SyaratKetentuanPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D3557),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Image.asset(
                      'lib/images/logo.png',
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Masuk
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Syarat dan Ketentuan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Additional text
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sebelum menggunakan aplikasi ini, harap baca dan pahami syarat dan ketentuan berikut secara seksama. Dengan mengakses dan menggunakan aplikasi LenderUp, Anda secara tegas setuju untuk terikat oleh syarat dan ketentuan ini. Jika Anda tidak setuju dengan syarat dan ketentuan ini, harap berhenti menggunakan aplikasi ini.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            '1.',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Pendaftaran:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'a. Untuk menggunakan LenderUp, Anda harus berusia minimal 18 tahun dan memiliki kapasitas hukum yang sah.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'b. Saat mendaftar, Anda harus menyediakan informasi yang akurat, lengkap, dan terkini. Anda bertanggung jawab untuk menjaga kerahasiaan akun Anda dan tidak boleh memberikan akses ke akun Anda kepada pihak ketiga.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //---------------------------
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            '2.',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Verifikasi:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'a. Untuk menjaga keamanan dan kepatuhan, kami dapat meminta Anda untuk melengkapi proses verifikasi yang meliputi identitas, alamat, dan informasi keuangan. ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'b. Anda harus memberikan dokumen dan informasi yang valid dan benar selama proses verifikasi. ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'c. Kami berhak menolak aplikasi Anda jika dokumen atau informasi yang diberikan tidak memenuhi persyaratan kami.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //---------------------------
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            '3.',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Pinjaman:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'a. Dalam aplikasi LenderUp, Anda dapat mengajukan pinjaman dengan jumlah tertentu, suku bunga, dan jangka waktu yang ditentukan. ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'b. Anda harus memahami dan setuju untuk membayar pinjaman sesuai dengan ketentuan yang disepakati, termasuk jumlah pokok, bunga, dan biaya administrasi yang berlaku.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Buttons
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Perform action on "Selanjutnya" button press
                        },
                        child: Text('Selanjutnya'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFFB703),
                          textStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Perform action on "Lewati" button press
                        },
                        child: Text('Kembali'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFFB703),
                          textStyle: TextStyle(color: Colors.black),
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
