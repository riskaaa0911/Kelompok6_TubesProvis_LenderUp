import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/card_buat_pinjaman.dart';
import 'package:lender_up_19/reuseable_widgets/card_dompet.dart';
import 'package:lender_up_19/reuseable_widgets/card_pinjaman.dart';
import 'package:lender_up_19/reuseable_widgets/card_verifikasi.dart';
import 'package:lender_up_19/screens/Borrower/ajukan.dart';
import 'package:lender_up_19/screens/Borrower/pinjaman.dart';
import 'package:lender_up_19/screens/dompet_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lender_up_19/screens/profile_screen.dart';

class BorrowerHomeNonVerif extends StatefulWidget {
  final String accessToken;
  const BorrowerHomeNonVerif({Key? key, required this.accessToken})
      : super(key: key);

  @override
  State<BorrowerHomeNonVerif> createState() => _BorrowerHomeNonVerifState();
}

class _BorrowerHomeNonVerifState extends State<BorrowerHomeNonVerif> {
  int idx = 0; //index yang aktif

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  Widget getBodyWidget() {
    switch (idx) {
      case 0:
        return BorrowerHomeNonVerifikasi(accessToken: widget.accessToken);
      case 1:
        return AjukanScreen(accessToken: widget.accessToken);
      case 2:
        return PinjamanScreen(
          accessToken: widget.accessToken,
        );
      case 3:
        return DompetScreen(
          accessToken: widget.accessToken,
          is_in_lender: false,
        );
      case 4:
        return ProfileScreen(accessToken: widget.accessToken);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LenderUp',
      home: Scaffold(
        backgroundColor: const Color(0xFF1D3557),
        body: getBodyWidget(),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: const Color(0xFFFFB703),
          items: const [
            TabItem(icon: Icons.home, title: 'Beranda'),
            TabItem(icon: Icons.add, title: 'Ajukan'),
            TabItem(icon: Icons.attach_money, title: 'Pinjaman'),
            TabItem(icon: Icons.wallet, title: 'Dompet'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          initialActiveIndex: idx,
          onTap: (int index) {
            onItemTap(index);
          },
        ),
      ),
    );
  }
}

class BorrowerHomeNonVerifikasi extends StatefulWidget {
  final String accessToken;
  const BorrowerHomeNonVerifikasi({Key? key, required this.accessToken})
      : super(key: key);

  @override
  State<BorrowerHomeNonVerifikasi> createState() =>
      _BorrowerHomeNonVerifikasiState();
}

class _BorrowerHomeNonVerifikasiState extends State<BorrowerHomeNonVerifikasi> {
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
      getPinjamanDataDidanai(_borrowerData?['data']['id_borrower']);
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
      print(_dompetData);
    } else {
      // Handle error response
      print("dompet bermasalah");
    }
  }

  Future<void> getPinjamanDataDidanai(int id_borrower) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 20),
          child: Container(
              child: _userData != null
                  ? Text(
                      "Hai ${_userData?["username"]}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Text(
                      "Terdapat kesalahan API",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
        ),
        Container(
          padding: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skor Kredit",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _borrowerData != null
                  ? Text(
                      "${_borrowerData?["data"]["skor_kredit"]}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Text(
                      "Unknow",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
          // width: 88,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _dompetData != null
                ? getCardDompet(context, _dompetData?["data"]["saldo"],
                    _dompetData?["data"]["id_dompet"])
                : getCardDompet(context, 0, 0),
            if (_userData?["no_tlp"] == null) ...[
              if (_userData?["ID"] != null) // Periksa apakah ID tidak null
                getCardVerifikasi(context,
                    widget.accessToken) // Gunakan langsung tanpa konversi
            ],
            getCardPinjaman(
                context, totalMitra, totalSisaPokok, totalAngsuran, jatuhtempo),
            Container(
              alignment: Alignment.centerLeft,
              // padding: EdgeInsets.only(left: 20),
              child: Text(
                "Pengajuan",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                )),
              ),
            ),
            getCardBuatPinjaman(),
          ]),
        )
      ]),
    );
  }
}
