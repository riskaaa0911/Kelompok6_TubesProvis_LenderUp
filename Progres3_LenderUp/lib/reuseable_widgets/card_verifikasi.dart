import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up/screens/Lender/lengkapi_data_screen.dart';

Container getCardVerifikasi(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
    width: 500,
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(15),
    ),
    child: InkWell(
      onTap: () {
        // Navigasi ke halaman LengkapiData
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LengkapiDataPage()),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFFFB703),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Icon(Icons.assignment, size: 30, color: Color(0xFF1D3557)),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 150,
            child: Text(
              "Lengkapi data untuk keamanan dan aksesibilitas anda",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
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
                margin: EdgeInsets.only(right: 15, bottom: 7),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFB703),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          // Fungsi yang akan dijalankan ketika container dipencet
                          // Navigasi ke halaman LengkapiData
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LengkapiDataPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
