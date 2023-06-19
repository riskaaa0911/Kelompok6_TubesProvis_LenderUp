import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Container getFilter() {
  return Container(
    margin: EdgeInsets.only(left: 30, right: 20, bottom: 20),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Rp. 327.000",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ))),
      IconButton(
        iconSize: 15,
        icon: FaIcon(
          FontAwesomeIcons.filter,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ]),
  );
}
