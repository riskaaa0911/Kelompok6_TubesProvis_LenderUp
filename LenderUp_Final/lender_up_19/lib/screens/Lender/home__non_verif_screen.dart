import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/card_dompet.dart';
import 'package:lender_up_19/reuseable_widgets/card_porto_simple.dart';
import 'package:lender_up_19/reuseable_widgets/card_telusuri.dart';
import 'package:lender_up_19/reuseable_widgets/card_verifikasi.dart';
import 'package:lender_up_19/reuseable_widgets/total_aset.dart';
import 'package:lender_up_19/screens/Lender/porto_screen.dart';
import 'package:lender_up_19/screens/dompet_screen.dart';
import 'package:lender_up_19/screens/Lender/telusuri_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeNonVerifScreen extends StatefulWidget {
  final String accessToken;
  const HomeNonVerifScreen({Key? key, required this.accessToken})
      : super(key: key);
  @override
  State<HomeNonVerifScreen> createState() => _HomeNonVerifScreenState();
}

class _HomeNonVerifScreenState extends State<HomeNonVerifScreen> {
  int idx = 0; //index yang aktif

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  Widget getBodyWidget() {
    switch (idx) {
      case 0:
        return HomeNonVerifikasiScreen(accessToken: widget.accessToken);
      case 1:
        return TelusuriScreen(accessToken: widget.accessToken);
      case 2:
        return PortoScreen(accessToken: widget.accessToken);
      case 3:
        return DompetScreen(
          accessToken: widget.accessToken,
          is_in_lender: true,
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
            TabItem(icon: Icons.search, title: 'Telusuri'),
            TabItem(icon: Icons.bar_chart, title: 'Portofolio'),
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

class HomeNonVerifikasiScreen extends StatefulWidget {
  final String accessToken;
  const HomeNonVerifikasiScreen({Key? key, required this.accessToken})
      : super(key: key);

  @override
  State<HomeNonVerifikasiScreen> createState() =>
      _HomeNonVerifikasiScreenState();
}

class _HomeNonVerifikasiScreenState extends State<HomeNonVerifikasiScreen> {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _lenderData;
  Map<String, dynamic>? _dompetData;
  List<Map<String, dynamic>> pinjamanData = [];
  List<Map<String, dynamic>> pinjamanDataDidanai = [];
  num totalAset = 0;
  num totalProfit = 0;
  num totalSisaPokok = 0;
  num totalBagiHasil = 0;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    getPinjamanData();
  }

  Future<void> getPinjamanDataDidanai(int id_lender) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8000/tampil_semua_pinjaman_didanai/${id_lender}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          setState(() {
            pinjamanDataDidanai = List<Map<String, dynamic>>.from(data['data']);
          });
          // print(pinjamanDataDidanai);
          for (var pinjaman in pinjamanDataDidanai) {
            totalAset +=
                pinjaman['nominal_pinjaman'] + pinjaman['bagi_hasil_jmlh'];
            totalProfit += pinjaman['bagi_hasil_jmlh'];
            totalSisaPokok += pinjaman['nominal_pinjaman'] +
                pinjaman['bagi_hasil_jmlh'] -
                pinjaman["nominal_dilunasi"];
            totalBagiHasil += pinjaman['bagi_hasil_jmlh'];
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

  Future<void> getPinjamanData() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8000/tampil_semua_pinjaman/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          setState(() {
            pinjamanData = List<Map<String, dynamic>>.from(data['data']);
            // print(pinjamanData); // Cetak isi data pinjaman
          });
        } else {
          // Error handling jika data tidak tersedia
          print('Data pinjaman tidak tersedia.');
        }
      } else {
        // Error handling jika responsenya bukan 200
        print('Terjadi kesalahan. Kode respons: ${response.statusCode}');
      }
    } catch (e) {
      // Error handling jika terjadi kesalahan koneksi atau lainnya
      print('Terjadi kesalahan: $e');
    }
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
        _fetchUserLender();
        _fetchUserDompet();
      }
    } else {
      // Handle error response
    }
  }

  Future<void> _fetchUserLender() async {
    final url = Uri.parse('http://localhost:8000/lender/${_userData?["ID"]}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Data = jsonDecode(response.body);
      setState(() {
        _lenderData = Data;
      });
      print(_lenderData);
      getPinjamanDataDidanai(_lenderData?['data']['id_lender']);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1D3557),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            child: Row(
              children: [
                Container(
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
              ],
            ),
          ),
          getTotalAset(totalAset, totalProfit),
          Container(
            padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _dompetData != null
                    ? getCardDompet(context, _dompetData?["data"]["saldo"],
                        _dompetData?["data"]["id_dompet"])
                    : getCardDompet(context, 0, 0),
                if (_userData?["no_tlp"] == null) ...[
                  if (_userData?["ID"] != null) // Periksa apakah ID tidak null
                    getCardVerifikasi(context,
                        widget.accessToken) // Gunakan langsung tanpa konversi
                ],
                getCardPortoSimple(context, pinjamanDataDidanai.length,
                    totalSisaPokok, totalBagiHasil), // Portfolio card
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Telusuri",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200, // Sesuaikan sesuai kebutuhan Anda
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: CardPinjaman(
                        pinjamanData, context, _lenderData, _dompetData, false),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
