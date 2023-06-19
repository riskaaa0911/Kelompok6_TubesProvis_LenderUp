import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lender_up_19/reuseable_widgets/card_telusuri.dart';
import 'package:lender_up_19/reuseable_widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:lender_up_19/provider/Dompet.dart';

class TelusuriScreen extends StatefulWidget {
  final String accessToken;

  const TelusuriScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  TelusuriScreenState createState() => TelusuriScreenState();
}

class TelusuriScreenState extends State<TelusuriScreen> {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _lenderData;
  Map<String, dynamic>? _dompetData;
  List<Map<String, dynamic>> pinjamanData = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    getPinjamanData();
    _startPeriodicFetching();
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

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startPeriodicFetching() {
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      final dompet = context.read<Dompet>();
      dompet.fetchSaldo(_userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TELUSURI",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ]),
          ),
          getSearchBar(context),
          Container(
            margin: EdgeInsets.only(left: 30, right: 20, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<Dompet>(builder: (context, dompet, child) {
                    return Text(
                      'Rp. ${dompet.saldo}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                  /*Text("Rp. 327.000",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),*/
                  IconButton(
                    iconSize: 15,
                    icon: FaIcon(
                      FontAwesomeIcons.filter,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ]),
          ),
          Column(
            children: CardPinjaman(
                pinjamanData, context, _lenderData, _dompetData, false),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xff1D3557),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FILTER',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                  SizedBox(height: 20),
                  Text('Urutkan berdasarkan :',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                // Aksi saat item drawer di-tap
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xffFFB703), // Ubah warna sesuai keinginan
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'Plafond Tertinggi',
                  style: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                // Aksi saat item drawer di-tap
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xffFFB703), // Ubah warna sesuai keinginan
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'Bagi Hasil Tertinggi',
                  style: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                // Aksi saat item drawer di-tap
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xffFFB703), // Ubah warna sesuai keinginan
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'Tenor Terlama',
                  style: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                // Aksi saat item drawer di-tap
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xffFFB703), // Ubah warna sesuai keinginan
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'Tenor Tercepat',
                  style: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
