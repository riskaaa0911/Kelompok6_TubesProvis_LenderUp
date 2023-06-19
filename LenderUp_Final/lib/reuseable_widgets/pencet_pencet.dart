import 'package:flutter/material.dart';

Widget getCardSignUp(String imagePath, String text, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: Color(0xFFFFB703),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        // padding: const EdgeInsets.all(22.0),
        width: 110,
        margin: EdgeInsets.all(18),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 40,
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1d3557),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
