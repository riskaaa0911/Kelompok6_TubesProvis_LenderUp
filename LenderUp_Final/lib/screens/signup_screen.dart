import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:lender_up_19/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  Future<void> _register() async {
    final url = Uri.parse('http://localhost:8000/register');
    final response = await http.post(
      url,
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
        'full_name': _fullNameController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];

      // Simpan token di sini (misalnya menggunakan shared_preferences)
      print('Access Token: $accessToken');

      // Navigasi ke halaman berikutnya setelah berhasil registrasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Registration failed. Please try again.'),
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
      appBar: buildProfileAppBar(context, "Sign Up"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1D3557),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Daftar sebagai lender",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 20),
                reusableTextField(
                  "Masukan Username",
                  false,
                  _fullNameController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Masukan Email",
                  false,
                  _emailController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Masukan Password",
                  true,
                  _passwordController,
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _register();
                    },
                    style: ElevatedButton.styleFrom(
                      // Atur warna latar belakang tombol
                      primary: Color(0xFFFFB703),
                    ),
                    child: Text("Sign Up",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d3557),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
