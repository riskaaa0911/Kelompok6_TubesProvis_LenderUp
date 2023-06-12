import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PinjamanScreen extends StatefulWidget {
  @override
  _PinjamanScreenState createState() => _PinjamanScreenState();
}

class _PinjamanScreenState extends State<PinjamanScreen>
    with SingleTickerProviderStateMixin {
  int idx = 2;
  double progressValue = 1;
  late TabController _tabController;

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildSheet(context) => Container(
        decoration: BoxDecoration(
          color: Color(0xffffb703),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25, top: 40),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff97979797),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "Peternak Lele",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "Batujajar, Kab. Bandung Barat, Jawa Barat",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tanggal Lunas",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        "dd/mm/yyyy",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF1D3557)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Detail Pinjaman',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plafond',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Rp 4.000.000',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pendanaan ke',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah pemberi dana',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tenor',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '50 Minggu',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bagi hasil',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Rp 480.000',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jenis angsuran',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Mingguan',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah angsuran',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Rp 89.600',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Akad',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Perjanjian Pendanaan',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pemberi Dana',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Add your cards here
                    for (int i = 0; i < 5; i++) generateCard3(),
                    // Add more cards as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D3557),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3557),
        title: Text('PINJAMAN'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.grey,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              child: Text(
                'Pinjaman Aktif',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Riwayat Pinjaman',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Pembayaran',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: ListView(
              children: [
                // Add more cards for Tab 1
                generateContainer(),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: [
                SizedBox(height: 20.0),
                generalcontainer2(),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: [
                // Add cards for Tab 3
                SizedBox(height: 20.0),
                generateCard('Pendanaan', '25 Jan 2023', 'Rp. 327.000'),
                for (int i = 0; i < 5; i++)
                  generateCard2('Pendanaan', '25 Jan 2023', '-Rp. 327.000'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generateCard(String title, String subtitle, String jumlah) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, right: 30, left: 30, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () {},
        leading: ClipOval(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 4), // Add space below the title row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              Text(jumlah,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black)),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4), // Add space above the subtitle row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.red)),
              Text('Ajukan Perpanjangan',
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  Widget generateCard2(String title, String subtitle, String jumlah) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, right: 30, left: 30, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () {},
        leading: ClipOval(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 4), // Add space below the title row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              Text(jumlah,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black)),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4), // Add space above the subtitle row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.green)),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }

  Widget generateCard3() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 220,
        height: 80,
        child: ListTile(
          leading: ClipOval(
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          title: Text("Nama"),
          subtitle: Text("Rp. 1.000.000",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onTap: () {
            // Handle onTap action
          },
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
    );
  }

  Widget generateContainer() {
    double progressValue = 0.6; // Nilai progres antara 0.0 hingga 1.0
    return Container(
      margin: EdgeInsets.only(bottom: 15, right: 30, left: 30, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pinjaman Aktif',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progres Pendanaan',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey,
                valueColor:
                    AlwaysStoppedAnimation<Color>(const Color(0xFFFFB703)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sisa Pokok',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Angsuran',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Jatuh Tempo',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp 2.000.000',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp 89.600/minggu',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dd/mm/yyyy',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detail Pinjaman',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plafond',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Rp 4.000.000',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pendanaan ke',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah pemberi dana',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tenor',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '50 Minggu',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bagi hasil',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Rp 480.000',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jenis angsuran',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Mingguan',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Akad',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Perjanjian Pendanaan',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generalcontainer2() {
    double progressValue = 1;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: 400,
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xffffffffff),
        borderRadius: BorderRadius.circular(15),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                      Text("Tanggal Lunas: dd/mm/yyyy",
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
                      //_showBottomSheet(context);
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
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFFFB703)),
          ),
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
    );
  }
}
