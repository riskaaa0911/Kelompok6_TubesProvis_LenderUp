import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:lender_up_19/reuseable_widgets/signUpOption.dart';
import 'package:lender_up_19/screens/Borrower/borrower_home_non_verif.dart';
import 'package:lender_up_19/screens/Lender/home__non_verif_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  Future<void> _login(String target) async {
    final url = Uri.parse('http://localhost:8000/token');
    final response = await http.post(
      url,
      body: {
        'username': _emailTextController.text,
        'password': _passwordTextController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];

      // Simpan token di sini (misalnya menggunakan shared_preferences)
      print('Access Token: $accessToken');

      if (target == "Lender") {
        // Navigasi ke halaman berikutnya setelah berhasil login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeNonVerifScreen(accessToken: accessToken),
          ),
        );
      } else if (target == "Borrower") {
        // Navigasi ke halaman berikutnya setelah berhasil login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BorrowerHomeNonVerif(accessToken: accessToken),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Login failed. Please check your credentials.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "Sign In"),
      body: Container(
        color: Color(0xFF1D3557),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                  "Masukan Email",
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Masukan Password",
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => _login("Lender"),
                    style: ElevatedButton.styleFrom(
                      // Atur warna latar belakang tombol
                      primary: Color(0xFFFFB703),
                    ),
                    child: Text("Login sebagai Lender",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d3557),
                        ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => _login("Borrower"),
                    style: ElevatedButton.styleFrom(
                      // Atur warna latar belakang tombol
                      primary: Color(0xFFFFB703),
                    ),
                    child: Text("Login sebagai Borrower",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d3557),
                        ))),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
