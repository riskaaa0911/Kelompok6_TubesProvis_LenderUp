import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PortoScreen extends StatefulWidget {
  const PortoScreen({Key? key}) : super(key: key);
  @override
  PortoScreenState createState() {
    return PortoScreenState();
  }
}

class PortoScreenState extends State<PortoScreen> {
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("PORTOFOLIO",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ))),
                      IconButton(
                        iconSize: 15,
                        icon: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      )
                    ]),
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
                      Text("Rp.0",
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
                      Text("0",
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
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => buildSheet(context),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: 400,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xffffffffff),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          // margin: EdgeInsets.only(left: 10),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff97979797)),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Asep Komarudin",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Text("Peternak Lele",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600)))
                                    ])),
                            Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Status Pembayaran",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                      Text("AMAN",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xff6EB13A),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)))
                                    ])),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text("Sisa Pokok",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 8,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ))),
                                ),
                                Container(
                                  child: Text("Rp. 2.000.000",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ))),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  // margin:
                                  // EdgeInsets.only(left: 70, right: 70),
                                  child: Text("Bagi Hasil",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xff1D3557),
                                        fontSize: 8,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ))),
                                ),
                                Container(
                                  // margin:
                                  // EdgeInsets.only(left: 70, right: 70),
                                  child: Text("12%",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ))),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}

// @override
Widget buildSheet(context) => Container(
    decoration: BoxDecoration(
        color: Color(0xffffb703),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    height: 400,
    child: Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, top: 40),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff97979797)),
            ),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500))),
                      Text("Peternak Lele",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500))),
                      Text("Batujajar, Kab. Bandung Barat, Jawa Barat",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w300))),
                    ])),
            Container(
                margin: EdgeInsets.only(top: 40, right: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Status Pembayaran",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700))),
                      Text("AMAN",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xff6EB13A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)))
                    ])),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text("Plafond",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(0xff1D3557),
                        fontSize: 8,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
                Container(
                  child: Text("Rp. 4.000.000",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  // margin:
                  // EdgeInsets.only(left: 70, right: 70),
                  child: Text("Bagi Hasil",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(0xff1D3557),
                        fontSize: 8,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
                Container(
                  // margin:
                  // EdgeInsets.only(left: 70, right: 70),
                  child: Text("12%",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  // margin:
                  // EdgeInsets.only(left: 70, right: 70),
                  child: Text("Tenor",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(0xff1D3557),
                        fontSize: 8,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
                Container(
                  // margin:
                  // EdgeInsets.only(left: 70, right: 70),
                  child: Text("50 Minggu",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))),
                ),
              ],
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tentang Mitra",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Pendanaan ke",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Penghasilan Perbulan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Pekerjaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Sektor",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text("1",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 4.500.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Peternak Lele",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Peternakan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ])
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Pembayaran",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Tenor Pendanaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Bagi Hasil",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Jenis Angsuran",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Jumlah Angsuran",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Akad",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text("50 Minggu",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 500.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Mingguan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 100.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Perjanjian Pendanaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ])
            ],
          ),
        ),
      ],
    )));
