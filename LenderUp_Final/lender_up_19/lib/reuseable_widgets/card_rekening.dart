import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getCardRekening(String title, String subtitle) {
  return Card(
    margin: EdgeInsets.only(bottom: 15, right: 30, left: 30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0,
    child: ListTile(
      onTap: () {},
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          fit: BoxFit.cover,
          width: 70,
          height: 60,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500))),
          Text(subtitle,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    ),
  );
}
