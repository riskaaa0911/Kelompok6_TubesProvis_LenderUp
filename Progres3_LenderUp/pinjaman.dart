import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransaksiBorrower {
  int jumlah;
  String tanggalTransaksi;
  String jenisTransaksi;
  TransaksiBorrower(
      {required this.jumlah,
      required this.tanggalTransaksi,
      required this.jenisTransaksi});
}

class PinjamanAktif {
  int plafond;
  int bagiHasil;
  int tenor;
  PinjamanAktif(
      {required this.plafond, required this.bagiHasil, required this.tenor});
}

class PinjamanSelesai {
  int plafond;
  int bagiHasil;
  int tenor;
  String namaUmkm;
  String tglLunas;
  PinjamanSelesai(
      {required this.plafond,
      required this.bagiHasil,
      required this.tenor,
      required this.namaUmkm,
      required this.tglLunas});
}

class Transaksi {
  List<TransaksiBorrower> listTransaksi = <TransaksiBorrower>[];

  Transaksi(Map<String, dynamic> json) {
    var data = json["data"]; //bentuknya hirarkis, ambil elemen "data"
    for (var val in data) {
      var jumlah = val["jumlah"]; //thn dijadikan int
      var tanggalTransaksi = val["tanggal_transaksi"];
      var jenisTransaksi = val["jenis_transaksi"];
//tambahkan ke array
      listTransaksi.add(TransaksiBorrower(
          jumlah: jumlah,
          tanggalTransaksi: tanggalTransaksi,
          jenisTransaksi: jenisTransaksi));
    }
  }
//map dari json ke atribut
  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(json);
  }
}

class Pinjaman {
  List<PinjamanAktif> listPinjaman = <PinjamanAktif>[];

  Pinjaman(Map<String, dynamic> json) {
    var data = json["data"]; //bentuknya hirarkis, ambil elemen "data"
    for (var val in data) {
      var plafond = val["plafond"]; //thn dijadikan int
      var bagiHasil = val["bagi_hasil"];
      var tenor = val["tenor"];
//tambahkan ke array
      listPinjaman.add(
          PinjamanAktif(plafond: plafond, bagiHasil: bagiHasil, tenor: tenor));
    }
  }
//map dari json ke atribut
  factory Pinjaman.fromJson(Map<String, dynamic> json) {
    return Pinjaman(json);
  }
}

class RiwayatPinjaman {
  List<PinjamanSelesai> listPinjamanSelesai = <PinjamanSelesai>[];

  RiwayatPinjaman(Map<String, dynamic> json) {
    var data = json["data"]; //bentuknya hirarkis, ambil elemen "data"
    for (var val in data) {
      var plafond = val["plafond"]; //thn dijadikan int
      var bagiHasil = val["bagi_hasil"];
      var tenor = val["tenor"];
      var tglLunas = val["tanggal_lunas"];
      var namaUmkm = val["nama_umkm"];
//tambahkan ke array
      listPinjamanSelesai.add(PinjamanSelesai(
          plafond: plafond,
          bagiHasil: bagiHasil,
          tenor: tenor,
          tglLunas: tglLunas,
          namaUmkm: namaUmkm));
    }
  }
//map dari json ke atribut
  factory RiwayatPinjaman.fromJson(Map<String, dynamic> json) {
    return RiwayatPinjaman(json);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lender Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int idx = 2;
  double progressValue = 1;
  late TabController _tabController;
  int borrowerid = 1;
  late Future<Transaksi> futureTransaksi;

  //https://datausa.io/api/data?drilldowns=Nation&measures=Population
  String url = "http://127.0.0.1:8000/tampilkan_transaksi_borrower2/";

  //fetch data
  Future<Transaksi> fetchData() async {
    final response = await http.get(Uri.parse((url) + '$borrowerid'));

    if (response.statusCode == 200) {
      // jika server mengembalikan 200 OK (berhasil),
      // parse json
      return Transaksi.fromJson(jsonDecode(response.body));
    } else {
      // jika gagal (bukan  200 OK),
      // lempar exception
      throw Exception('Gagal load');
    }
  }

  late Future<Pinjaman> futurePinjamanAktif;

  //https://datausa.io/api/data?drilldowns=Nation&measures=Population
  String urlPinjamanAktif = "http://127.0.0.1:8000/tampilkan_pinjaman_aktif/";

  //fetch data
  Future<Pinjaman> fetchDataPinjaman() async {
    final response =
        await http.get(Uri.parse((urlPinjamanAktif) + '$borrowerid'));

    if (response.statusCode == 200) {
      // jika server mengembalikan 200 OK (berhasil),
      // parse json
      return Pinjaman.fromJson(jsonDecode(response.body));
    } else {
      // jika gagal (bukan  200 OK),
      // lempar exception
      throw Exception('Gagal load');
    }
  }

  late Future<RiwayatPinjaman> futurePinjamanSelesai;

  //https://datausa.io/api/data?drilldowns=Nation&measures=Population
  String urlPinjamanSelesai =
      "http://127.0.0.1:8000/tampilkan_pinjaman_selesai/";

  //fetch data
  Future<RiwayatPinjaman> fetchDataPinjamanSelesai() async {
    final response =
        await http.get(Uri.parse((urlPinjamanSelesai) + '$borrowerid'));

    if (response.statusCode == 200) {
      // jika server mengembalikan 200 OK (berhasil),
      // parse json
      return RiwayatPinjaman.fromJson(jsonDecode(response.body));
    } else {
      // jika gagal (bukan  200 OK),
      // lempar exception
      throw Exception('Gagal load');
    }
  }

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    futureTransaksi = fetchData();
    futurePinjamanAktif = fetchDataPinjaman();
    futurePinjamanSelesai = fetchDataPinjamanSelesai();
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
            child: FutureBuilder<Pinjaman>(
              future: futurePinjamanAktif,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    //gunakan listview builder
                    child: ListView.builder(
                      itemCount: snapshot
                          .data!.listPinjaman.length, //asumsikan data ada isi
                      itemBuilder: (context, index) {
                        double progressValue =
                            0.6; // Nilai progres antara 0.0 hingga 1.0
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: 15, right: 30, left: 30, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                    0, 2), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        const Color(0xFFFFB703)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Plafond',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Rp. " +
                                            snapshot.data!.listPinjaman[index]
                                                .plafond
                                                .toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tenor',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.listPinjaman[index].tenor
                                                .toString() +
                                            " Minggu",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bagi hasil',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Rp. " +
                                            snapshot.data!.listPinjaman[index]
                                                .bagiHasil
                                                .toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          //Tab 2
          Center(
            child: FutureBuilder<RiwayatPinjaman>(
              future: futurePinjamanSelesai,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    //gunakan listview builder
                    child: ListView.builder(
                      itemCount: snapshot.data!.listPinjamanSelesai
                          .length, //asumsikan data ada isi
                      itemBuilder: (context, index) {
                        double progressValue = 1;
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff97979797)),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Nama",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                              Text(
                                                  snapshot
                                                      .data!
                                                      .listPinjamanSelesai[
                                                          index]
                                                      .namaUmkm,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                              Text(
                                                  "Tanggal Lunas: " +
                                                      snapshot
                                                          .data!
                                                          .listPinjamanSelesai[
                                                              index]
                                                          .tglLunas,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight
                                                              .w300))),
                                            ])),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 20, right: 14),
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFffb703)),
                                      child: Stack(children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 3, left: 1),
                                          child: IconButton(
                                            iconSize: 20,
                                            icon: FaIcon(FontAwesomeIcons.plus),
                                            onPressed: () {
                                              //_showBottomSheet(context);
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    buildSheet(context),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        const Color(0xFFFFB703)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          child: Text(
                                              "Rp. " +
                                                  snapshot
                                                      .data!
                                                      .listPinjamanSelesai[
                                                          index]
                                                      .plafond
                                                      .toString(),
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
                                          child: Text(
                                              "Rp. " +
                                                  snapshot
                                                      .data!
                                                      .listPinjamanSelesai[
                                                          index]
                                                      .bagiHasil
                                                      .toString(),
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
                                          child: Text(
                                              snapshot
                                                      .data!
                                                      .listPinjamanSelesai[
                                                          index]
                                                      .tenor
                                                      .toString() +
                                                  " Minggu",
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
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          Center(
            child: FutureBuilder<Transaksi>(
              future: futureTransaksi,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    //gunakan listview builder
                    child: ListView.builder(
                      itemCount: snapshot
                          .data!.listTransaksi.length, //asumsikan data ada isi
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(
                              bottom: 10, right: 30, left: 30, top: 5),
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
                              padding: EdgeInsets.only(
                                  bottom: 4), // Add space below the title row
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      snapshot.data!.listTransaksi[index]
                                          .jenisTransaksi,
                                      style: TextStyle(fontSize: 16)),
                                  Text(
                                      "-" +
                                          snapshot
                                              .data!.listTransaksi[index].jumlah
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                  top: 4), // Add space above the subtitle row
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      snapshot.data!.listTransaksi[index]
                                          .tanggalTransaksi,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green)),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ajukan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'Pinjaman'),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Dompet"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ]),
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
