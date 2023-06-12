import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lender_up/screens/Borrower/ajukan.dart';
import 'package:lender_up/screens/Borrower/pinjaman.dart';
import 'package:lender_up/screens/Lender/home__non_verif_screen.dart';
import 'package:lender_up/screens/Lender/porto_screen.dart';
import 'package:lender_up/screens/dompet_screen.dart';
import 'package:lender_up/screens/profile_screen.dart';
import 'package:lender_up/screens/telusuri_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BorrowerHomeNonVerif extends StatefulWidget {
  const BorrowerHomeNonVerif({super.key});

  @override
  State<BorrowerHomeNonVerif> createState() => _BorrowerHomeNonVerifState();
}

class _BorrowerHomeNonVerifState extends State<BorrowerHomeNonVerif> {
  int idx = 0; //index yang aktif

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  Widget getBodyWidget() {
    switch (idx) {
      case 0:
        return const BorrowerHomeNonVerifikasi();
      case 1:
        return const AjukanScreen();
      case 2:
        return PinjamanScreen();
      case 3:
        return const DompetScreen();
      case 4:
        return const ProfileScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LenderUp',
      home: Scaffold(
        backgroundColor: const Color(0xFF1D3557),
        body: getBodyWidget(),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: const Color(0xFFFFB703),
          items: const [
            TabItem(icon: Icons.home, title: 'Beranda'),
            TabItem(icon: Icons.add, title: 'Ajukan'),
            TabItem(icon: Icons.attach_money, title: 'Pinjaman'),
            TabItem(icon: Icons.wallet, title: 'Dompet'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          initialActiveIndex: idx,
          onTap: (int index) {
            onItemTap(index);
          },
        ),
      ),
    );
  }
}

class BorrowerHomeNonVerifikasi extends StatefulWidget {
  const BorrowerHomeNonVerifikasi({super.key});

  @override
  State<BorrowerHomeNonVerifikasi> createState() =>
      _BorrowerHomeNonVerifikasiState();
}

class _BorrowerHomeNonVerifikasiState extends State<BorrowerHomeNonVerifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 20),
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
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 15,
                  color: Colors.white,
                ),
                onPressed: () {},
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
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
                          "Rp.500.000",
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
                              icon: Icon(Icons.arrow_circle_up,
                                  size: 30, color: Colors.black),
                              onPressed: () {},
                            ),
                            Text(
                              "Deposit",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Color(0xff1D3557),
                                  fontSize: 8,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_circle_down,
                                  size: 30, color: Colors.black),
                              onPressed: () {},
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
                          ]),
                    ),
                  ]),
            ),
            // batasberes
            Container(
              margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
              width: 500,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(15),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    margin: EdgeInsets.only(right: 15),
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFB703),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                    child: Icon(Icons.assignment,
                        size: 30, color: Color(0xff1D3557))),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 150,
                  child: Text(
                    "Lengkapi data untuk keamanan dan aksebilitas anda",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    )),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Stack(children: [
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFFFB703))),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {},
                      ),
                    ),
                  ]),
                )
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ),
          ]),
        )
      ]),
    );
  }
}
