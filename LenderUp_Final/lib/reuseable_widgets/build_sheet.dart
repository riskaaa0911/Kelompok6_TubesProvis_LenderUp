import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/reuseable_widgets/build_sheet_mendanai.dart';
import 'package:intl/intl.dart';

Widget buildSheet(context, Map<String, dynamic> data, bool in_porto,
        Map<String, dynamic>? lenderData, Map<String, dynamic>? dompetData) =>
    Container(
        decoration: BoxDecoration(
            color: Color(0xffffb703),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        height: 500,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40, top: 40),
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name']!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          Text(data['description']!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))),
                          Text(data['location']!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300))),
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
                      child: Text("Nominal Pinjaman",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xff1D3557),
                            fontSize: 8,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    ),
                    Container(
                      child: Text(
                        "Rp. ${NumberFormat('#,###').format(data['nominal_pinjaman'])}",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
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
                      child: Text("${data['bagi_hasil_persen'].toString()}%",
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
                      child: Text("${data['tenor'].toString()} bulan",
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
              margin: EdgeInsets.only(left: 40),
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Penghasilan Perbulan",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ))),
                        Text("Deskripsi",
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
                    Text(
                      "Rp. ${NumberFormat('#,###').format(data['penghasilan_per_bulan'])}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(data['description']!,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ))),
                    Text(data['sektor']!,
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
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    Text("${data['tenor'].toString()} bulan",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ))),
                    Text(
                      "Rp. ${NumberFormat('#,###').format(data['bagi_hasil_jmlh'])}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "Rp. ${NumberFormat('#,###').format(data['jumlah_angsuran'])}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(data['akad']!,
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
              margin: EdgeInsets.only(top: 10),
              height: 80,
              width: double.infinity,
              color: Color(0XFF1D3557),
              child: in_porto == false
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Aksi yang akan dilakukan saat tombol ditekan
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => buildSheetMendanai(
                                  data, lenderData, dompetData),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Menentukan radius border
                            ), // Mengatur ukuran tombol
                            primary: Color(
                                0xffFFB703), // Mengatur warna latar belakang tombol
                          ),
                          child: Text(
                            'Mulai Mendanai?',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Color(0XFF1D3557),
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ), // Mengatur gaya teks tombol
                          ),
                        ),
                      ],
                    )
                  : null,
            )
          ],
        )));
