import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lender_up_19/reuseable_widgets/With_Draw.dart';
import 'package:lender_up_19/screens/dompet_screen.dart';
import 'package:lender_up_19/reuseable_widgets/Top_Up.dart';

Container getCardDompet(BuildContext context, double saldo, int id_dompet) {
  return Container(
    margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
    width: 500,
    height: 80,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Saldo Dompet",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              'Rp ${saldo.toStringAsFixed(2).replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]}.',
                  )}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon:
                    Icon(Icons.arrow_circle_up, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopUp(
                              id_dompet: id_dompet,
                            )),
                  );
                },
              ),
              Text(
                "Top Up",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 8,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_circle_down,
                    size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WithDraw(
                              id_dompet: id_dompet,
                            )),
                  );
                },
              ),
              Text(
                "Withdraw",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 8,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
