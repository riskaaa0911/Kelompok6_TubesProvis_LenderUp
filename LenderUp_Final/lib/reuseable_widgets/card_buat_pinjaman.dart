import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container getCardBuatPinjaman() {
  return Container(
    margin: EdgeInsets.fromLTRB(1.5, 20, 0, 20),
    width: 500,
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 10,
          ),
          width: 150,
          child: Text(
            "Buat Permintaan Pinjaman",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(left: 37),
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFB703),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, left: 10),
                    child: IconButton(
                      iconSize: 60,
                      icon: Icon(Icons.arrow_right_alt_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
