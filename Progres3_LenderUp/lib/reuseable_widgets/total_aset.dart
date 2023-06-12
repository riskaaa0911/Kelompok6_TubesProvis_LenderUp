import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container getTotalAset() {
  return Container(
    padding: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Asetmu",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "Rp.0",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Total profil Rp 0",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.green,
              fontSize: 8,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
