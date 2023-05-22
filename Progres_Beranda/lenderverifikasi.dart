import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:flutter_icons/flutter_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  int idx = 0; //index yang aktif

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello App',
        home: Scaffold(
          backgroundColor: Color(0xFF1D3557),
          body: ListView(children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 20),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "HAI, USER",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  FaIcon(
                    FontAwesomeIcons.bell,
                    size: 15,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Asetmu",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "Rp.0",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "Total profil Rp 0",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 8,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 0),
              // width: 88,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
                      width: 500,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saldo Dompet',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Text(
                                'Rp. 327.000',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 300, top: 15),
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                // margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                width: 40,
                                height: 25.3,
                                decoration:
                                    BoxDecoration(color: Color(0xff979797)),
                              ),
                              Text(
                                'Deposit',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 350, top: 15),
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                // margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                width: double.infinity,
                                height: 25.3,
                                decoration:
                                    BoxDecoration(color: Color(0xff979797)),
                              ),
                              Text(
                                'Withdraw',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
                        width: 500,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15, left: 15),
                              child: Text(
                                "Pendanaan Aktif",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                )),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 15, left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      )),
                                      children: [
                                        TextSpan(
                                          text: 'Kamu sedang mendanai ',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                            color: Color(0xff4e4e4e),
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          )),
                                        ),
                                        TextSpan(
                                          text: '0',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w800,
                                          )),
                                        ),
                                        TextSpan(
                                          text: ' mitra',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                            color: Color(0xff4e4e4e),
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          )),
                                        ),
                                      ]),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 15, left: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 70, right: 70),
                                          child: Text("Sisa Pokok",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 70, right: 70),
                                          child: Text("Rp 0",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w800,
                                              ))),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 70, right: 70),
                                          child: Text("Bagi Hasil Diterima",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 70, right: 70),
                                          child: Text("Rp 0",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w800,
                                              ))),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Telusuri",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(1.5, 20, 0, 20),
                      width: 500,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, top: 8),
                                // padding: EdgeInsets.only(: 10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF979797)),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 17, left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // margin: EdgeInsets.only(top: 10),
                                    children: [
                                      Text(
                                        "Nama",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        )),
                                      ),
                                      Text(
                                        "Peternal Lele",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        )),
                                      ),
                                      Text(
                                        "Batujajar, Kab. Bandung Barat, Jawa Barat",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                        )),
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 90),
                                child: Stack(children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 12, left: 5),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFFB703))),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: IconButton(
                                      iconSize: 15,
                                      icon: Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    // margin:
                                    // EdgeInsets.only(left: 70, right: 70),
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
                                    // margin:
                                    // EdgeInsets.only(left: 70, right: 70),
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
                        ],
                      ),
                    ),
                  ]),
            )
          ]),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xFFFFB703),
              elevation: 0, // Hilangkan efek bayangan
              type: BottomNavigationBarType.fixed, // Hilangkan efek gradient
              // backgroundColor: Colors.yellow,
              currentIndex: idx,
              selectedItemColor: Color(0xFF1D3557),
              unselectedItemColor: Colors.white,
              onTap: onItemTap,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Beranda'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Telusuri"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notification_add), label: 'Portfolio'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.wallet), label: "Dompet"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profil"),
              ]),
        ));
  }
}
