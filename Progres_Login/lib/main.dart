import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/lengkapi_data_page.dart';
import 'pages/lupa_password_page.dart';
import 'pages/ktp_selfie_page.dart';
import 'pages/rekening_page.dart';
import 'pages/syarat_ketentuan_page.dart';
import 'pages/daftar_lender_page.dart';
import 'pages/daftar_borrower_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: DaftarLenderPage(),
      // home: DaftarBorrowerPage(),
      // home: LoginPage(),
      // home: LengkapiDataPage(),
      // home: LupaPasswordPage(),
      // home: KtpSelfiePage(),
      home: RekeningPage(),
      // home: SyaratKetentuanPage(),
    );
  }
}
