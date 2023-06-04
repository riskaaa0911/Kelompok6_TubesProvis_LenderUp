import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 150,
    height: 150,
  );
  // SvgPicture.asset(
  //   'assets/images/logo.svg',
  //   width: 80,
  //   height: 80,
  // );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Color(0xFFFFB703);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFFB703),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF1D3557),
      unselectedItemColor: Colors.white,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Telusuri',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_add),
          label: 'Portfolio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'Dompet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}

AppBar buildProfileAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          // Handle the action when the person icon is pressed
          // For example, navigate to another screen or show a menu
        },
      ),
    ],
  );
}

FractionallySizedBox reusableButton(
    String text, bool arrow, BuildContext context, Function onTap) {
  return FractionallySizedBox(
    widthFactor: 1.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF1D3557),
                ),
              ),
            ),
            if (arrow)
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF1D3557),
                size: 20.0,
              ),
          ],
        ),
      ),
    ),
  );
}

Container AkunBankCard(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 1.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(
              "https://mir-s3-cdn-cf.behance.net/projects/404/12ed31104606189.Y3JvcCwzOTk5LDMxMjgsMCw5NDA.png",
            ),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bank Mandiri",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Nama Pemilik Akun",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  "No. Rekening",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// @override
Widget buildSheet(context) => Container(
    decoration: BoxDecoration(
        color: Color(0xffffb703),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    height: 500,
    child: Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 40, top: 40),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff97979797)),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 40),
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
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tentang Mitra",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Pendanaan ke",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Penghasilan Perbulan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Pekerjaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Sektor",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text("1",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 4.500.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Peternak Lele",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Peternakan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ])
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Pembayaran",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xff000000),
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
              )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Tenor Pendanaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Bagi Hasil",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Jenis Angsuran",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Jumlah Angsuran",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Akad",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text("50 Minggu",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 500.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Mingguan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Rp. 100.000",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ))),
                Text("Perjanjian Pendanaan",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    )))
              ])
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 80,
          width: double.infinity,
          color: Color(0XFF1D3557),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aksi yang akan dilakukan saat tombol ditekan
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => buildSheetMendanai(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Menentukan radius border
                  ), // Mengatur ukuran tombol
                  primary:
                      Color(0xffFFB703), // Mengatur warna latar belakang tombol
                ),
                child: Text(
                  'Mulai Mendanai?',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0XFF1D3557),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  )), // Mengatur gaya teks tombol
                ),
              ),
            ],
          ),
        )
      ],
    )));

// @override
Widget buildSheetMendanai() => Container(
    decoration: BoxDecoration(
        color: Color(0xffffb703),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
    height: 450,
    child: Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 40, top: 30),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff97979797)),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 30),
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
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
                  margin: EdgeInsets.only(top: 5),
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
                  margin: EdgeInsets.only(top: 5),
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
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                // margin: EdgeInsets.only(left: 30),
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xff1D3557),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  // margin: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      onPressed: () {},
                      iconSize: 20,
                      color: Color(0xfffffffff),
                      icon: Icon(Icons.remove)),
                )),
            Container(
              // margin: EdgeInsets.only(right: 10, left: 10),
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                color: Color(0xffffffffff),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Rp.100.000",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Color(0xff1d3557),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                )),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                // margin: EdgeInsets.only(right: 30),
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xff1d3557),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                      onPressed: () {},
                      iconSize: 20,
                      color: Color(0xfffffffff),
                      icon: Icon(Icons.add)),
                )),
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  // margin: EdgeInsets.only(right: 30),
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff1d3557),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Rp.400rb",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xfffffffff),
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            )))),
                  )),
              Container(
                  // margin: EdgeInsets.only(right: 0),
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff1d3557),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Rp.1jt",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xfffffffff),
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            )))),
                  )),
              Container(
                  // margin: EdgeInsets.only(right: 30),
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff1d3557),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Rp.2jt",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xfffffffff),
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            )))),
                  )),
              Container(
                  // margin: EdgeInsets.only(right: 30),
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff1d3557),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Max",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xfffffffff),
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            )))),
                  )),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Dana Tersedia Rp. 327.000",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
            Text("Sisa Plafond Rp.100.000",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 150,
          width: double.infinity,
          color: Color(0XFF1D3557),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pembayaran dari Mitra",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ))),
                          Text("Total Hasil",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ))),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Rp.2.240/Minggu",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ))),
                          Text("Rp.112.000",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ))),
                        ])
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Menentukan radius border
                    ), // Mengatur ukuran tombol
                    primary: Color(
                        0xffFFB703), // Mengatur warna latar belakang tombol
                  ),
                  child: Text(
                    'Beri Modal',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0XFF1D3557),
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )), // Mengatur gaya teks tombol
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    )));

Widget generateCard(String title, String subtitle, String jumlah) {
  return Card(
    margin: EdgeInsets.only(bottom: 15, right: 50, left: 50),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(jumlah,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16), // Add contentPadding to remove the gray border
    ),
  );
}

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB703),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Masuk",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
