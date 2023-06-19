import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lender_up_19/reuseable_widgets/card_porto.dart';

class PortoScreen extends StatefulWidget {
  final String accessToken;
  const PortoScreen({Key? key, required this.accessToken}) : super(key: key);
  @override
  PortoScreenState createState() {
    return PortoScreenState();
  }
}

class PortoScreenState extends State<PortoScreen> {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _lenderData;
  Map<String, dynamic>? _dompetData;
  List<Map<String, dynamic>> pinjamanData = [];
  num totalAset = 0;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> getPinjamanData(int id_lender) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8000/tampil_semua_pinjaman_didanai/${id_lender}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          setState(() {
            pinjamanData = List<Map<String, dynamic>>.from(data['data']);
          });
          // print(pinjamanData);
          for (var pinjaman in pinjamanData) {
            totalAset +=
                pinjaman['nominal_pinjaman'] + pinjaman['bagi_hasil_jmlh'];
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
      print(_lenderData?['data']['id_lender']);
      getPinjamanData(_lenderData?['data']['id_lender']);
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
    return MaterialApp(
      title: 'LenderUp',
      home: Scaffold(
          backgroundColor: Color(0xFF1D3557),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                // child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                child: Text("PORTOFOLIO",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),

                // ]),
              ),
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Aset Saya",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text("Rp.${totalAset}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xffFFB703),
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ))),
                    ]),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 25, 30, 10),
                  child: Text("Progress Pendanaan",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(0xffFFffff),
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      )))),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Container(
                      width: 100,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Color(0xffffb703),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jumlah Mitra",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xffFFffff),
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                      Text("${pinjamanData.length}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xffFFffff),
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: Text("Daftar Mitra",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xffFFffff),
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),
              ),
              Column(
                children:
                    CardPorto(pinjamanData, context, _lenderData, _dompetData),
              ),
            ],
          )),
    );
  }
}
