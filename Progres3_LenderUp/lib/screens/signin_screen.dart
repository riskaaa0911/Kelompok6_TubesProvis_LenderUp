import 'package:flutter/material.dart';
import 'package:lender_up/reuseable_widgets/reusable_widged.dart';
import 'package:lender_up/reuseable_widgets/signUpOption.dart';
import 'package:lender_up/screens/Borrower/borrower_home_non_verif.dart';
import 'package:lender_up/screens/Lender/home__non_verif_screen.dart';
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
            builder: (context) => BorrowerHomeNonVerif(),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign In",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
                  "Enter Username",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 10,
                ),
                UIButton(context, "Sign in as Lender", () => _login("Lender")),
                UIButton(
                    context, "Sign in as Borrower", () => _login("Borrower")),
                signUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
