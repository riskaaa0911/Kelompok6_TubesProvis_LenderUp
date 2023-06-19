import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getTitleInputForm(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '${title}',
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
        )),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
