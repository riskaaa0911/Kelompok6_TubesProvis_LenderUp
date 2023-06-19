import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Container getTotalAset(num aset, num profit) {
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
          "Rp. ${NumberFormat('#,###').format(aset)}",
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
          "Total profit Rp ${NumberFormat('#,###').format(profit)}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
