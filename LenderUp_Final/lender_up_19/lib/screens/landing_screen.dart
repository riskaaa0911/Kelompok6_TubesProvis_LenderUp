import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/pencet_pencet.dart';
// import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/screens/signin_screen.dart';
import 'package:lender_up_19/screens/signup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<List<dynamic>> fetchData() async {
    final apiUrl = 'http://localhost:8000/tampilkan_semua_faq';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['data'];
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height *
            0.5, // Tinggi minimum panel saat terlipat
        maxHeight: MediaQuery.of(context).size.height *
            0.8, // Tinggi maksimum panel saat terbuka
        defaultPanelState:
            PanelState.OPEN, // Panel akan terbuka saat pertama kali dibuka
        body: Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/dami.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context)
                .size
                .width, // Sesuaikan dengan kebutuhan Anda
          ),
        ), // Rounded corners untuk panel
        panel: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              color: Color(0xFF1D3557),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Selamat Datang',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(
                                  0xFFFFB703), // Mengubah warna latar belakang tombol
                            ),
                            child: Text(
                              "Masuk",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1d3557),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Belum Punya Akun?',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: getCardSignUp(
                                'assets/images/lender.png',
                                'Daftar sebagai\nLender',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 24), // Jarak antara card
                            Expanded(
                              child: getCardSignUp(
                                'assets/images/borrower.png',
                                'Daftar sebagai\nBorrower',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'FAQ',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<List<dynamic>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Menampilkan indikator loading saat data sedang diambil
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Menampilkan pesan error jika gagal mengambil data
                        return Text('Failed to fetch data: ${snapshot.error}');
                      } else {
                        // Menampilkan data FAQ jika berhasil diambil
                        final dataList = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Color(0xFFFFB703),
                              child: ExpansionTile(
                                title: Text(
                                  dataList[index]['pertanyaan'],
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1D3557),
                                    ),
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      dataList[index]['jawaban'],
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF1D3557)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
