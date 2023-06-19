import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container getCardPinjaman(BuildContext context, num jumlh_pinjaman,
    num sisa_pokok, num angsuran, String tanggal) {
  return Container(
      margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
      width: 500,
      height: 150,
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
              "Pinjaman Aktif",
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
            margin: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              "Kamu ${jumlh_pinjaman} memiliki pinjaman aktif",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff4F4F4F),
                fontSize: 10,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              )),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 25, left: 15, right: 15),
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
                        child: Text("Rp ${sisa_pokok}",
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
                        child: Text("Angsuran",
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
                        child: Text("Rp ${angsuran}/bulan",
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
                        child: Text("Jatuh Tempo",
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
                        child: Text("${tanggal}",
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
