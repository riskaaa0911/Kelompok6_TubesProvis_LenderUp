import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container getSearchBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Cari...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          iconSize: 15,
          icon: FaIcon(
            FontAwesomeIcons.search,
            color: Colors.white,
          ),
          onPressed: () {
            // Aksi ketika tombol pencarian ditekan
          },
        ),
      ],
    ),
  );
}
