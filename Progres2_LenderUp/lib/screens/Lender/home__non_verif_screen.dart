import 'package:flutter/material.dart';
import 'package:lander_up/reuseable_widgets/reusable_widged.dart';
import 'package:lander_up/screens/Lender/lengkapi_data_screen.dart';
import 'package:lander_up/screens/Lender/porto_screen.dart';
import 'package:lander_up/screens/dompet_screen.dart';
import 'package:lander_up/screens/telusuri_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lander_up/screens/profile_screen.dart';

// import 'package:flutter_icons/flutter_icons.dart';

void main() {
  runApp(const HomeNonVerifScreen());
}

class HomeNonVerifScreen extends StatefulWidget {
  const HomeNonVerifScreen({Key? key}) : super(key: key);
  @override
  HomeNonVerifScreenState createState() {
    return HomeNonVerifScreenState();
  }
}

class HomeNonVerifScreenState extends State<HomeNonVerifScreen> {
  int idx = 0; //index yang aktif

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  Widget getBodyWidget() {
    switch (idx) {
      case 0:
        return const HomeNonVerifikasiScreen();
      case 1:
        return const TelusuriScreen();
      case 2:
        return const PortoScreen();
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
            TabItem(icon: Icons.search, title: 'Telusuri'),
            TabItem(icon: Icons.bar_chart, title: 'Portofolio'),
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

class HomeNonVerifikasiScreen extends StatefulWidget {
  const HomeNonVerifikasiScreen({Key? key}) : super(key: key);

  @override
  State<HomeNonVerifikasiScreen> createState() =>
      _HomeNonVerifikasiScreenState();
}

class _HomeNonVerifikasiScreenState extends State<HomeNonVerifikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1D3557),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            child: Row(
              children: [
                InkWell(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: 15,
                  ),
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
                      fontSize: 20,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TopUp()),
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
                            // margin: EdgeInsets.only(right: 20),
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
                                          builder: (context) => WithDraw()),
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
                        ]),
                  ),
                  // batasberes
                  Container(
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
                          MaterialPageRoute(
                              builder: (context) => LengkapiDataPage()),
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
                            child: Icon(Icons.assignment,
                                size: 30, color: Color(0xFF1D3557)),
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
                          Container(
                            margin: EdgeInsets.only(left: 15),
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
                                            builder: (context) =>
                                                LengkapiDataPage()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.fromLTRB(1.5, 0, 0, 20),
                      width: 500,
                      height: 120,
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
                              margin: EdgeInsets.only(top: 8, left: 15),
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
                              margin:
                                  EdgeInsets.only(top: 15, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    height: 200, // Atur sesuai kebutuhan Anda
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: buildContentItems(),
                    ),
                  ),
                ]),
          )
        ]));
  }

  List<Widget> buildContentItems() {
    List<Widget> items = [];

    // Data dummy untuk konten item
    List<Map<String, String>> dummyData = [
      {
        'name': 'Peternak 1',
        'description': 'Peternak Ayam',
        'location': 'Bandung, Jawa Barat',
        'plafond': 'Rp. 4.000.000',
        'bagiHasil': '12%',
        'tenor': '50 Minggu',
      },
      {
        'name': 'Peternak 2',
        'description': 'Peternak Kambing',
        'location': 'Surabaya, Jawa Timur',
        'plafond': 'Rp. 3.000.000',
        'bagiHasil': '10%',
        'tenor': '40 Minggu',
      },
      {
        'name': 'Peternak 3',
        'description': 'Peternak Lele',
        'location': 'Surabaya, Jawa Timur',
        'plafond': 'Rp. 3.000.000',
        'bagiHasil': '10%',
        'tenor': '40 Minggu',
      },
      // Tambahkan data dummy lainnya jika diperlukan
    ];

    // Loop untuk membuat konten item secara dinamis
    for (var data in dummyData) {
      items.add(
        Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 17),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF979797),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          data['description']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          data['location']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 38),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFB703),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3, left: 30),
                          child: IconButton(
                            iconSize: 15,
                            icon: FaIcon(FontAwesomeIcons.plus),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Text(
                          "Plafond",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xFF1D3557),
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          data['plafond']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Text(
                          "Bagi Hasil",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xFF1D3557),
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          data['bagiHasil']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Text(
                          "Tenor",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xFF1D3557),
                              fontSize: 8,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          data['tenor']!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }
}
