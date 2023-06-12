import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lander_up/reuseable_widgets/reusable_widged.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DompetScreen());
}

class Dompet {
  final int dompetId;
  final int akunId;
  final int saldo;

  Dompet({required this.dompetId, required this.akunId, required this.saldo});

  factory Dompet.fromJson(Map<String, dynamic> json) {
    return Dompet(
      dompetId: json['data'][0][0] as int,
      akunId: json['data'][0][1] as int,
      saldo: json['data'][0][2] as int,
    );
  }
}

class TransaksiEntry {
  final int transaksiId;
  final int borrowerId;
  final int lenderId;
  final int jumlah;
  final String tanggalTransaksi;
  final String jenisTransaksi;

  TransaksiEntry({
    required this.transaksiId,
    required this.borrowerId,
    required this.lenderId,
    required this.jumlah,
    required this.tanggalTransaksi,
    required this.jenisTransaksi,
  });

  factory TransaksiEntry.fromJson(Map<String, dynamic> json) {
    return TransaksiEntry(
      transaksiId: json[0] as int,
      borrowerId: json[1] as int,
      lenderId: json[2] as int,
      jumlah: json[3] as int,
      tanggalTransaksi: json[4] as String,
      jenisTransaksi: json[5] as String,
    );
  }
}

class Transaksi {
  final List<TransaksiEntry> entries;

  Transaksi({required this.entries});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    List<TransaksiEntry> entries =
        List<TransaksiEntry>.from(json['data'].map((entry) {
      return TransaksiEntry(
        transaksiId: entry[0] as int,
        borrowerId: entry[1] as int,
        lenderId: entry[2] as int,
        jumlah: entry[3] as int,
        tanggalTransaksi: entry[4] as String,
        jenisTransaksi: entry[5] as String,
      );
    }));

    return Transaksi(entries: entries);
  }
}

class DompetScreen extends StatefulWidget {
  const DompetScreen({Key? key}) : super(key: key);

  DompetScreenState createState() => DompetScreenState();
}

class DompetScreenState extends State<DompetScreen> {
  late Future<Dompet> futureDompet; // future menampung hasil
  late Future<Transaksi> futureTransaksi; // future menampung hasil
  String urlDompet = "http://127.0.0.1:8000/get_wallet/";
  String urlTransaksi = "http://127.0.0.1:8000/get_transaction/";
  int loggedAccount = 1;
  String accountType = "lender";

  //fetch saldo data from API
  Future<Dompet> fetchDataDompet() async {
    final response = await http.get(Uri.parse(urlDompet + '$loggedAccount'));
    if (response.statusCode == 200) {
      return Dompet.fromJson(jsonDecode(response.body));
    } else {
      //jika gagal (bukan 200 OK)
      throw Exception('Gagal Panggil API');
    }
  }

  //fetch transaction data from API
  Future<Transaksi> fetchDataTransaksi() async {
    final response =
        await http.get(Uri.parse(urlTransaksi + '$accountType/$loggedAccount'));
    if (response.statusCode == 200) {
      return Transaksi.fromJson(jsonDecode(response.body));
    } else {
      //jika gagal (bukan 200 OK)
      throw Exception('Gagal Panggil API');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDompet = fetchDataDompet();
    futureTransaksi = fetchDataTransaksi();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lender Up',
      home: Scaffold(
        backgroundColor: const Color(0xFF1D3557),
        body: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DOMPET",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ))),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dana Tersedia',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<Dompet>(
                      future: futureDompet,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Rp. ${snapshot.data!.saldo}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFB703),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            '{$snapshot.error}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                        //default: loading spinner
                        return const CircularProgressIndicator();
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TopUp()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFB703),
                          ),
                          child: Transform.scale(
                            scale: 1.2, // faktor skala
                            child: Icon(
                              Icons.add,
                              color: const Color(0xFF1D3557),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Top Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithDraw()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFB703),
                          ),
                          child: Transform.scale(
                            scale: 1.2, // faktor skala
                            child: Icon(
                              Icons.arrow_downward,
                              color: const Color(0xFF1D3557),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Withdraw',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Riwayat()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFB703),
                          ),
                          child: Transform.scale(
                            scale: 1.2, // faktor skala
                            child: Icon(
                              Icons.list,
                              color: const Color(0xFF1D3557),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Riwayat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Transaksi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AKTIVITAS :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Pilih Bulan',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),
            Center(
              child: FutureBuilder(
                future: futureTransaksi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Transaksi transaksi = snapshot.data as Transaksi;
                    List<TransaksiEntry> entries = transaksi.entries;

                    return Container(
                      height: 100.00 * entries.length,
                      child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          TransaksiEntry entry = entries[index];
                          String symbol = '+';
                          if ((entry.jenisTransaksi == "Pendanaan" &&
                                  accountType == "lender") ||
                              (entry.jenisTransaksi == "Pelunasan" &&
                                  accountType == "borrower")) {
                            symbol = '-';
                          }
                          return generateCard(
                              entry.jenisTransaksi,
                              entry.tanggalTransaksi,
                              '${symbol}Rp. ${entry.jumlah}');
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            // Generate cards using a loop
          ],
        ),
      ),
    );
  }
}

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  TopUpState createState() => TopUpState();
}

class TopUpState extends State<TopUp> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "TOP UP"),
      backgroundColor: const Color(0xFF1D3557),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 50, right: 50, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOMPET',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Changed to MainAxisAlignment.start
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Up  :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Transfer via ATM atau Internet banking ke salah satu virtual akun berikut:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.0),
          // Generate cards using a loop
          for (int i = 0; i < 5; i++)
            generateCard('No. Virtual Account', 'XXXXXXXXXXXXXX', '0'),

          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget generateCard(String title, String subtitle, String jumlah) {
    return Card(
      margin: EdgeInsets.only(bottom: 15, right: 50, left: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () {},
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            fit: BoxFit.cover,
            width: 70,
            height: 60,
          ),
        ),
        title: Text(title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            )),
        subtitle: Text(subtitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        trailing: Container(
          width: 45,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              jumlah,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      ),
    );
  }
}

class WithDraw extends StatefulWidget {
  const WithDraw({Key? key}) : super(key: key);

  @override
  WithDrawState createState() => WithDrawState();
}

class WithDrawState extends State<WithDraw> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "Withdraw"),
      backgroundColor: const Color(0xFF1D3557),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 50, right: 50, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOMPET',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarik Dana',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Biaya Transfer +Rp 2.900',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp. 0',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFB703),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      //borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dana Tersedia',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Rp 0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    'Tarik',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 56, 104),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Handle the "Selesai" button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB703),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 60.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Informasi Rekening Saya',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bank',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Bank Mandiri',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pemilik Akun',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Nama',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. Rekening',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'XXXXXXXXXXXXXX',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class Riwayat extends StatefulWidget {
  const Riwayat({Key? key}) : super(key: key);

  @override
  RiwayatState createState() => RiwayatState();
}

class RiwayatState extends State<Riwayat> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "Riwayat"),
      backgroundColor: const Color(0xFF1D3557),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 50, right: 50, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOMPET',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RIWAYAT :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Pilih Bulan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.0),
          // Generate cards using a loop
          for (int i = 0; i < 5; i++)
            generateCard('Bank Mandiri', 'Nama Pemilik Akun', '+Rp. 327.000'),

          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
