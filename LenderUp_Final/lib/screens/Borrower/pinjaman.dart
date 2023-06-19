import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:provider/provider.dart';

import 'package:lender_up_19/reuseable_widgets/card_telusuri.dart';

import 'package:lender_up_19/provider/Dompet.dart';
import 'package:lender_up_19/provider/PinjamanInfo.dart';

class PinjamanScreen extends StatefulWidget {
  final String accessToken;
  const PinjamanScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<PinjamanScreen> createState() => _PinjamanScreenState();
}

class _PinjamanScreenState extends State<PinjamanScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _borrowerData;
  Map<String, dynamic>? _dompetData;
  List<Map<String, dynamic>> pinjamanDataDidanai = [];
  num totalMitra = 0;
  num totalAset = 0;
  num totalProfit = 0;
  num totalSisaPokok = 0;
  num totalBagiHasil = 0;
  num totalAngsuran = 0;
  String jatuhtempo = '';
  int plafond = 0;

  late Timer _timer;

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
        _fetchUserDompet();
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
      _getPinjamanDataDidanai(_borrowerData?['data']['id_borrower']);
      Provider.of<PinjamanInfo>(context, listen: false)
          .getPinjamanDataDidanai(_borrowerData?['data']['id_borrower']);
    } else {
      // Handle error response
    }
  }

  Future<void> _fetchUserDompet() async {
    final url = Uri.parse('http://localhost:8000/dompet/${_userData?["ID"]}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dompetData = jsonDecode(response.body);
      setState(() {
        _dompetData = dompetData;
      });
      Provider.of<Dompet>(context, listen: false)
          .updateSaldo(dompetData['data']['saldo']);
      print(_dompetData);
    } else {
      // Handle error response
      print("dompet bermasalah");
    }
  }

  Future<void> _getPinjamanDataDidanai(int id_borrower) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8000/tampil_semua_pinjaman_borrower/${id_borrower}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          setState(() {
            pinjamanDataDidanai = List<Map<String, dynamic>>.from(data['data']);
          });
          // print(pinjamanDataDidanai);
          for (var pinjaman in pinjamanDataDidanai) {
            if (pinjaman['status'] == 'didanai') {
              totalMitra++;
              totalAset +=
                  pinjaman['nominal_pinjaman'] + pinjaman['bagi_hasil_jmlh'];
              totalProfit += pinjaman['bagi_hasil_jmlh'];
              totalSisaPokok += pinjaman['nominal_pinjaman'] +
                  pinjaman['bagi_hasil_jmlh'] -
                  pinjaman["nominal_dilunasi"];
              totalBagiHasil += pinjaman['bagi_hasil_jmlh'];
              totalAngsuran += pinjaman['jumlah_angsuran'];
              jatuhtempo = pinjaman['tanggal_jatuh_tempo'];
            }
          }
          print(totalAset);
        } else {
          print('Data pinjaman tidak tersedia.');
        }
      } else {
        print('Terjadi kesalahan. Kode respons: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  int idx = 2;
  double progressValue = 1;
  late TabController _tabController;

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _startPeriodicFetching();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startPeriodicFetching() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      final dompet = context.read<Dompet>();
      dompet.fetchSaldo(_userData);
      final PinjamanInfo info = context.read<PinjamanInfo>();
      info.getPinjamanDataDidanai(_borrowerData?['data']['id_borrower']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D3557),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3557),
        title: Container(
            margin: EdgeInsets.fromLTRB(16, 40, 30, 20),
            child: Text('PINJAMAN',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                )))),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.grey,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              child: Text('Pinjaman Aktif',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
            Tab(
              child: Text('Semua Pinjaman',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
            Tab(
              child: Text('Pembayaran',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: ListView(
              children: [
                // Add more cards for Tab 1
                GetCardBorrowerInfo(),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: CardPinjaman(pinjamanDataDidanai, context,
                  _borrowerData, _dompetData, true),
            ),
            // child: ListView(
            //   children: [
            //     SizedBox(height: 20.0),
            //     generalcontainer2(),
            //   ],
            // ),
          ),
          Center(
            child: ListView(
              children: [
                // Add cards for Tab 3
                SizedBox(height: 20.0),
                generateCard('Pendanaan', '25 Jan 2023', 'Rp. 327.000'),
                for (int i = 0; i < 5; i++)
                  CardRiwayat('Pendanaan', '25 Jan 2023', '-Rp. 327.000'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generateCard(String title, String subtitle, String jumlah) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, right: 30, left: 30, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () {},
        leading: ClipOval(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 4), // Add space below the title row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
              Text(jumlah,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4), // Add space above the subtitle row
          child:
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: [
              Text(subtitle,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
          //   Text('Ajukan Perpanjangan',
          //       style: TextStyle(fontSize: 12, color: Colors.black)),
          // ],
          // ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  Widget CardRiwayat(String title, String subtitle, String jumlah) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, right: 30, left: 30, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () {},
        leading: ClipOval(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 4), // Add space below the title row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
              Text(jumlah,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ))),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4), // Add space above the subtitle row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  //todo make this dynamic
  Widget GetCardBorrowerInfo() {
    //double progressValue = 0.6; // Nilai progres antara 0.0 hingga 1.0
    return Consumer<PinjamanInfo>(
      builder: (context, provider, _) {
        // Get the data from the provider
        final totalMitra = provider.totalMitra;
        final totalSisaPokok = provider.totalSisaPokok;
        final totalAngsuran = provider.totalAngsuran;
        final jatuhtempo = provider.jatuhtempo;

        // Calculate the progress value
        final progressValue =
            0.6; // Update this with your actual progress value

        return Container(
          margin: EdgeInsets.only(bottom: 15, right: 30, left: 30, top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Anda Memiliki $totalMitra Pinjaman Aktif',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progres Pendanaan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.grey,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(const Color(0xFFFFB703)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sisa Pokok',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Angsuran',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Jatuh Tempo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rp $totalSisaPokok',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('Rp $totalAngsuran/bulan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('$jatuhtempo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
                // Add the remaining widgets here
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Detail Pinjaman',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Plafond',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('Rp ${plafond}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pendanaan ke',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('1',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jumlah pemberi dana',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('${totalMitra}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tenor',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('50 Minggu',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bagi hasil',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('Rp ${totalBagiHasil}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jenis angsuran',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('Bulanan',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Akad',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text('Perjanjian Pendanaan',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    /*Container(
      margin: EdgeInsets.only(bottom: 15, right: 30, left: 30, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Anda Memiliki ${totalMitra} Pinjaman Aktif',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progres Pendanaan',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey,
                valueColor:
                    AlwaysStoppedAnimation<Color>(const Color(0xFFFFB703)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sisa Pokok',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                  Text('Angsuran',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                  Text('Jatuh Tempo',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rp ${totalSisaPokok}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('Rp ${totalAngsuran}/bulan',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('${jatuhtempo}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detail Pinjaman',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Plafond',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('Rp ${plafond}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pendanaan ke',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('1',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jumlah pemberi dana',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('${totalMitra}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tenor',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('50 Minggu',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bagi hasil',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('Rp ${totalBagiHasil}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jenis angsuran',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('Bulanan',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Akad',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                  Text('Perjanjian Pendanaan',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );*/
  }

  // Widget generalcontainer2() {
  //   double progressValue = 1;
  //   return Container(
  //     margin: EdgeInsets.only(left: 20, right: 20),
  //     padding: EdgeInsets.only(top: 10, bottom: 10),
  //     width: 400,
  //     height: 150,
  //     decoration: BoxDecoration(
  //       color: Color(0xffffffffff),
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child:
  //         Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //       Row(
  //         // margin: EdgeInsets.only(left: 10),
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //               margin: EdgeInsets.only(left: 20),
  //               child: ClipOval(
  //                   child: Image.network(
  //                 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
  //                 fit: BoxFit.cover,
  //                 width: 50,
  //                 height: 50,
  //               ))),
  //           Container(
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                 Text("Nama",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.w500))),
  //                 Text("Peternak Lele",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.w500))),
  //                 Text("Tanggal Lunas: dd/mm/yyyy",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.w300))),
  //               ])),
  //           Container(
  //             margin: EdgeInsets.only(bottom: 20, right: 14),
  //             width: 35,
  //             height: 35,
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle, color: Color(0xFFffb703)),
  //             child: Stack(children: [
  //               Container(
  //                 margin: EdgeInsets.only(bottom: 3, left: 1),
  //                 child: IconButton(
  //                   iconSize: 20,
  //                   icon: FaIcon(FontAwesomeIcons.plus),
  //                   onPressed: () {
  //                     //_showBottomSheet(context);
  //                     showModalBottomSheet(
  //                       isScrollControlled: true,
  //                       backgroundColor: Colors.transparent,
  //                       context: context,
  //                       builder: (context) => buildSheet(context),
  //                     );
  //                   },
  //                 ),
  //               )
  //             ]),
  //           ),
  //         ],
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(left: 20, right: 20),
  //         child: LinearProgressIndicator(
  //           value: progressValue,
  //           backgroundColor: Colors.grey,
  //           valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFFFB703)),
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Column(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: 20),
  //                 child: Text("Plafond",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Color(0xff1D3557),
  //                       fontSize: 8,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //               Container(
  //                 child: Text("Rp. ${plafond}",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 10,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: 20),
  //                 // margin:
  //                 // EdgeInsets.only(left: 70, right: 70),
  //                 child: Text("Bagi Hasil",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Color(0xff1D3557),
  //                       fontSize: 8,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //               Container(
  //                 // margin:
  //                 // EdgeInsets.only(left: 70, right: 70),
  //                 child: Text("12%",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 10,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: 20),
  //                 // margin:
  //                 // EdgeInsets.only(left: 70, right: 70),
  //                 child: Text("Tenor",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Color(0xff1D3557),
  //                       fontSize: 8,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //               Container(
  //                 // margin:
  //                 // EdgeInsets.only(left: 70, right: 70),
  //                 child: Text("6 bulan",
  //                     style: GoogleFonts.poppins(
  //                         textStyle: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 10,
  //                       fontStyle: FontStyle.normal,
  //                       fontWeight: FontWeight.w600,
  //                     ))),
  //               ),
  //             ],
  //           )
  //         ],
  //       )
  //     ]),
  //   );
  // }
}
