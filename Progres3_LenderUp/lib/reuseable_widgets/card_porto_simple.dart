import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container getCardPortoSimple(BuildContext context) {
  return Container(
      margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
      width: 500,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              "Pendanaan Aktif",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              )),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 8, left: 15),
              child: RichText(
                text: TextSpan(
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    )),
                    children: [
                      TextSpan(
                        text: 'Kamu sedang mendanai ',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff4e4e4e),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      TextSpan(
                        text: '0',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                        )),
                      ),
                      TextSpan(
                        text: ' mitra',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0xff4e4e4e),
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ]),
              )),
          Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        // left: 70, right: 70),
                        child: Text("Sisa Pokok",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ))),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        // left: 70, right: 70),
                        child: Text("Rp 0",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                            ))),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        // left: 70, right: 70),
                        child: Text("Bagi Hasil Diterima",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ))),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        // left: 70, right: 70),
                        child: Text("Rp 0",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                            ))),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ));
}
