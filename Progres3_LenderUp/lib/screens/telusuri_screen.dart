import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lender_up/reuseable_widgets/reusable_widged.dart';

class TelusuriScreen extends StatefulWidget {
  const TelusuriScreen({Key? key}) : super(key: key);
  @override
  TelusuriScreenState createState() {
    return TelusuriScreenState();
  }
}

class TelusuriScreenState extends State<TelusuriScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("TELUSURI",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
            IconButton(
              iconSize: 15,
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 20, bottom: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          width: 400,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xffffffffff),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  // margin: EdgeInsets.only(left: 10),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff97979797)),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500))),
                              Text("Peternak Lele",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))),
                              Text("Batujajar, Kab. Bandung Barat, Jawa Barat",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300))),
                            ])),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 14),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFffb703)),
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3, left: 1),
                          child: IconButton(
                            iconSize: 20,
                            icon: FaIcon(FontAwesomeIcons.plus),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => buildSheet(context),
                              );
                            },
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("Plafond",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 8,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                        Container(
                          child: Text("Rp. 4.000.000",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          // margin:
                          // EdgeInsets.only(left: 70, right: 70),
                          child: Text("Bagi Hasil",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 8,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                        Container(
                          // margin:
                          // EdgeInsets.only(left: 70, right: 70),
                          child: Text("12%",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          // margin:
                          // EdgeInsets.only(left: 70, right: 70),
                          child: Text("Tenor",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(0xff1D3557),
                                fontSize: 8,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                        Container(
                          // margin:
                          // EdgeInsets.only(left: 70, right: 70),
                          child: Text("50 Minggu",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                      ],
                    )
                  ],
                )
              ]),
        ),
      ],
    );
  }
}
