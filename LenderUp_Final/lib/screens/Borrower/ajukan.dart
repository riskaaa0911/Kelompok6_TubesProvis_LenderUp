import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lender_up_19/reuseable_widgets/input_form_pengajuan.dart';
import 'dart:convert';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';

class AjukanScreen extends StatefulWidget {
  final String accessToken;
  const AjukanScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<AjukanScreen> createState() => _AjukanScreenState();
}

class _AjukanScreenState extends State<AjukanScreen> {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _borrowerData;
  int plafond = 0;

  final namaUMKMController = TextEditingController();
  final deskripsiUMKMController = TextEditingController();
  final lokasiController = TextEditingController();
  final penghasilanBulanController = TextEditingController();
  final sektorUsahaController = TextEditingController();
  final bagiHasilController = TextEditingController();
  final tenorController = TextEditingController();
  final akadController = TextEditingController();
  final nominalPinjamanController = TextEditingController();

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
      print(_userData); // Mencetak data pengguna ke konsol
      if (_userData?["no_tlp"] != null) {
        _fetchUserBorrower();
      }
    } else {
      // Handle error response
    }
  }

  Future<void> _fetchUserBorrower() async {
    final url = Uri.parse('http://localhost:8000/borrower/${_userData?["ID"]}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final borrowerData = jsonDecode(response.body);
      setState(() {
        _borrowerData = borrowerData;
      });
      print("ini di pengajuan");
      print(_borrowerData);
      if (_borrowerData != null) {
        if (_borrowerData?["data"]["skor_kredit"] == "A") {
          setState(() {
            plafond = 20000000;
          });
        } else if (_borrowerData?["data"]["skor_kredit"] == "B") {
          setState(() {
            plafond = 15000000;
          });
        } else if (_borrowerData?["data"]["skor_kredit"] == "C") {
          setState(() {
            plafond = 10000000;
          });
        } else if (_borrowerData?["data"]["skor_kredit"] == "D") {
          setState(() {
            plafond = 5000000;
          });
        } else if (_borrowerData?["data"]["skor_kredit"] == "E") {
          setState(() {
            plafond = 3000000;
          });
        } else {
          setState(() {
            plafond = 1000000;
          });
        }
      } else {
        // Handle error response
      }
    }
  }

  Future<void> _Ajukan() async {
    final url = Uri.parse('http://localhost:8000/pinjaman_pengajuan');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      // Add form data to the request body
      'name': namaUMKMController.text,
      'description': deskripsiUMKMController.text,
      'location': lokasiController.text,
      'penghasilan_per_bulan': double.parse(penghasilanBulanController.text),
      'sektor': sektorUsahaController.text,
      'plafond': plafond,
      'bagi_hasil_persen': int.parse(bagiHasilController.text),
      'tenor': int.parse(tenorController.text),
      'akad': akadController.text,
      'id_borrower': _borrowerData?["data"]["id_borrower"],
      'nominal_pinjaman': double.parse(nominalPinjamanController.text),
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Handle successful response
      final responseData = jsonDecode(response.body);
      print(responseData); // Mencetak respons dari server ke konsol
    } else {
      // Handle error response
      print('Gagal menambah data pnegajuan pinjaman');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 40, 30, 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "PENGAJUAN",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama UMKM
                  getTitleInputForm("Nama UMKM"),
                  reusableTextField(
                    'Masukkan Nama UMKM',
                    false,
                    namaUMKMController,
                  ),
                  const SizedBox(height: 20),
                  // Deskripsi UMKM
                  getTitleInputForm("Deskripsi UMKM"),
                  reusableTextField(
                    'Masukkan Deskripsi UMKM',
                    false,
                    deskripsiUMKMController,
                  ),
                  const SizedBox(height: 20),
                  // Lokasi
                  getTitleInputForm("Lokasi"),
                  reusableTextField('Masukkan Lokasi', false, lokasiController),
                  const SizedBox(height: 20),
                  // Penghasilan per Bulan
                  getTitleInputForm("Penghasilan per Bulan(Rp)"),
                  reusableTextField(
                    'Masukkan Penghasilan per Bulan',
                    false,
                    penghasilanBulanController,
                  ),
                  const SizedBox(height: 20),
                  // Sektor Usaha
                  getTitleInputForm("Sektor Usaha"),
                  reusableTextField(
                    'Masukkan Sektor Usaha',
                    false,
                    sektorUsahaController,
                  ),
                  const SizedBox(height: 20),
                  // Plafond
                  getTitleInputForm("Plafond"),
                  Text(
                    "Rp ${plafond.toString()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Bagi Hasil
                  getTitleInputForm("Bagi Hasil(%)"),
                  reusableTextField(
                    'Masukkan Bagi Hasil',
                    false,
                    bagiHasilController,
                  ),
                  const SizedBox(height: 20),
                  // Tenor
                  getTitleInputForm("Tenor(dalam Bulan)"),
                  reusableTextField('Masukkan Tenor', false, tenorController),
                  const SizedBox(height: 20),
                  // Akad
                  getTitleInputForm("Akad"),
                  reusableTextField('Masukkan Akad', false, akadController),
                  const SizedBox(height: 20),
                  // Nominal Pinjaman
                  getTitleInputForm("Nominal Pinjaman(Rp)"),
                  reusableTextField(
                    'Masukkan Nominal Pinjaman',
                    false,
                    nominalPinjamanController,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _Ajukan, // Call the _Ajukan method
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
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class HomePage extends StatefulWidget {
//   final Map<String, dynamic>? borrowerData; // Add the parameter

//   const HomePage({Key? key, this.borrowerData}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentPageIndex = 0;
//   final List<Widget> _pages = [
//     FormPage1(),
//     LoanFormPage(),
//     SuccessPage(),
//   ];

//   final _formKey = GlobalKey<FormState>();

//   void _navigateToPage(int index) {
//     setState(() {
//       _currentPageIndex = index;
//     });
//   }

//   void _nextPage() {
//     if (_currentPageIndex < _pages.length - 1) {
//       setState(() {
//         _currentPageIndex++;
//       });
//     }
//   }

//   Widget _buildPageIndicator(int pageIndex) {
//     String pageName = '';
//     switch (pageIndex) {
//       case 0:
//         pageName = 'Profil UMKM';
//         break;
//       case 1:
//         pageName = 'Info Merchant';
//         break;
//       case 2:
//         pageName = 'Berhasil';
//         break;
//     }

//     bool isActive = _currentPageIndex == pageIndex;
//     return GestureDetector(
//       onTap: () {
//         _navigateToPage(pageIndex);
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 35.0,
//             height: 35.0,
//             margin: EdgeInsets.symmetric(horizontal: 25),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isActive ? Color(0xffFFB703) : Colors.white,
//             ),
//             child: Center(
//               child: Text(
//                 '${pageIndex + 1}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: isActive ? Color(0xFF1D3557) : Color(0xFF1D3557),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             pageName,
//             style: GoogleFonts.poppins(
//                 textStyle: TextStyle(
//               fontSize: 10.0,
//               color: isActive ? Colors.white : Colors.white,
//             )),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1D3557),
//       body: Column(
//         children: [
//           Container(
//               margin: EdgeInsets.fromLTRB(30, 40, 30, 20),
//               alignment: Alignment.centerLeft,
//               child: Text("PENGAJUAN",
//                   style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.bold,
//                   )))),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Container(
//               height: 100.0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   for (var i = 0; i < _pages.length; i++)
//                     _buildPageIndicator(i),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: _pages[_currentPageIndex],
//           ),
//         ],
//       ),
//     );
//     // );
//   }
// }

// class FormPage1 extends StatefulWidget {
//   @override
//   _FormPage1State createState() => _FormPage1State();
// }

// class _FormPage1State extends State<FormPage1> {
//   final _formKey = GlobalKey<FormState>();
//   String _umkmName = '';
//   String _umkmDeskripsi = '';
//   String _umkmAlamat = '';
//   String _umkmSektor = '';
//   int umkmIncome = 0;
// // batas beres
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30.0, right: 30.0, left: 30.0),
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 8.0),
//               getTitleInputForm("Nama UMKM"),
//               TextFormField(
//                 cursorColor: Colors.white,
//                 style: TextStyle(color: Colors.white.withOpacity(0.9)),
//                 decoration: InputDecoration(
//                   labelText: 'Masukkan Nama UMKM',
//                   labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
//                   fillColor: Colors.white.withOpacity(0.3),
//                   filled: true,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter UMKM name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _umkmName = value!;
//                 },
//               ),
//               SizedBox(height: 12.0),
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 width: double.infinity,
//                 height: 40,
//                 child: ElevatedButton(
//                   child: Text('Selanjutnya',
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff1d3557),
//                       ))),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       print('Nama UMKM: $_umkmName');
//                       final _homePageState =
//                           context.findAncestorStateOfType<_HomePageState>();
//                       _homePageState!._nextPage();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     // Atur warna latar belakang tombol
//                     primary: Color(0xFFFFB703),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoanFormPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   String _loanAmount = 'RP. 15.000.000,-'; // Default loan tenure
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30.0, right: 30.0, left: 30.0),
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               getTitleInputForm('Jumlah Plafond Pinjaman'),
//               TextFormField(
//                 cursorColor: Colors.white,
//                 style: TextStyle(color: Colors.white.withOpacity(0.9)),
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
//                   fillColor: Colors.white.withOpacity(0.3),
//                   filled: true,
//                 ),
//                 initialValue: _loanAmount,
//                 onSaved: (value) {
//                   _loanAmount = value!;
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter loan amount';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 50.0),
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 width: double.infinity,
//                 height: 40,
//                 child: ElevatedButton(
//                   child: Text('Selesai',
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff1d3557),
//                       ))),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       print('Loan Amount: $_loanAmount');
//                       final _homePageState =
//                           context.findAncestorStateOfType<_HomePageState>();
//                       _homePageState!._nextPage();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     // Atur warna latar belakang tombol
//                     primary: Color(0xFFFFB703),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SuccessPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Text('Pengajuan Pinjaman Berhasil!',
//                 style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.bold))),
//           ),
//           SizedBox(height: 30.0),
//           Icon(Icons.check, size: 120, color: Color(0xFFFFB703)),
//           SizedBox(height: 50.0),
//           Container(
//             margin: EdgeInsets.only(top: 20),
//             width: double.infinity,
//             height: 40,
//             child: ElevatedButton(
//               child: Text(
//                 'Lihat Pinjaman Saya',
//                 style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff1d3557),
//                 )),
//               ),
//               onPressed: () {
//                 // Handle the "Selesai" button press
//               },
//               style: ElevatedButton.styleFrom(
//                 // Atur warna latar belakang tombol
//                 primary: Color(0xFFFFB703),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.0),
//           TextButton(
//             child: Text(
//               'Kembali',
//               style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFffb703),
//               )),
//             ),
//             onPressed: () {
//               // Handle the "Kembali" button press
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
