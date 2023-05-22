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
                    "Skor Kredit",
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
                    "A",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
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
                                "Pinjaman Aktif",
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
                              child: Text(
                                "Kamu tidak memiliki pinjaman aktif",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Color(0xff4F4F4F),
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                )),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 15, left: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
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
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
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
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
                                          child: Text("Angsuran",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
                                          child: Text("Rp 0/minggu",
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
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
                                          child: Text("Jatuh Tempo",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(
                                          // left: 70, right: 70),
                                          child: Text("dd/mm/yy",
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
                        "Request",
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
                                right: 102,
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
                                )),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Stack(children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFB703),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
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
                              ]),
                            ),
                          ]),
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
                    icon: Icon(Icons.search), label: "Ajukan"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notification_add), label: 'Pinjaman'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.wallet), label: "Dompet"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profil"),
              ]),
        ));
  }
}
