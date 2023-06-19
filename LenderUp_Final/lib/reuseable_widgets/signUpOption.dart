import 'package:flutter/material.dart';
import 'package:lender_up_19/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have an account?",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(color: Colors.white70),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        },
        child: Text(
          " Sign Up",
          style: GoogleFonts.poppins(
            textStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
