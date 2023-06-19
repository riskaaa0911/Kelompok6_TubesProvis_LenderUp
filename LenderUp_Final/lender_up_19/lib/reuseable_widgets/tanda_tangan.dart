import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// batas beres
class TandaTanganPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Upload Tanda Tangan',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ))),
          ),
          SizedBox(height: 30.0),
          InkWell(
            onTap: () {
              // Handle the click event to add an image
            },
            child: Container(
              width: 250.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text('Browse',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ))),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              child: Text('Selanjutnya',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1d3557),
                  ))),
              onPressed: () {
                // final _homePageState =
                // context.findAncestorStateOfType<_HomePageState>();
                // _homePageState!._nextPage();
              },
              style: ElevatedButton.styleFrom(
                // Atur warna latar belakang tombol
                primary: Color(0xFFFFB703),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
