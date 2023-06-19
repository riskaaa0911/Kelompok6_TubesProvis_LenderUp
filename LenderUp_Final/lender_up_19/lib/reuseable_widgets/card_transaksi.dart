import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// done
Widget cardTransaksi(
    String title, String subtitle, String jumlah, bool is_in_lender) {
  String formattedJumlah =
      NumberFormat.decimalPattern().format(int.parse(jumlah));
  if (is_in_lender) {
    if (title == "Bayar Cicilan" || title == 'Top Up') {
      formattedJumlah = '+ Rp. $formattedJumlah';
    } else {
      formattedJumlah = '- Rp. $formattedJumlah';
    }
  } else {
    if (title == "Bayar Cicilan" || title == 'Withdraw') {
      formattedJumlah = '- Rp. $formattedJumlah';
    } else {
      formattedJumlah = '+ Rp. $formattedJumlah';
    }
  }
  return Card(
    margin: EdgeInsets.only(bottom: 15, right: 30, left: 30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0,
    child: ListTile(
      onTap: () {},
      leading: ClipOval(
        child: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          fit: BoxFit.cover,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600))),
          Text(formattedJumlah,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      subtitle: Text(subtitle,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color(0xff4F4F4F),
                  fontSize: 8,
                  fontWeight: FontWeight.w700))),
      contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16), // Add contentPadding to remove the gray border
    ),
  );
}
