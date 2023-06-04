import 'package:flutter/material.dart';
import 'package:lander_up/reuseable_widgets/reusable_widged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lander_up/screens/signin_screen.dart';
import 'package:lander_up/screens/signup_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<FaqItem> faqItems = [
    FaqItem(
      question: 'Pertanyaan 1',
      answer: 'Jawaban 1',
    ),
    FaqItem(
      question: 'Pertanyaan 2',
      answer: 'Jawaban 2',
    ),
    FaqItem(
      question: 'Pertanyaan 3',
      answer: 'Jawaban 3',
    ),
    // FaqItem(
    //   question: 'Pertanyaan 4',
    //   answer: 'Jawaban 4',
    // ),
    // FaqItem(
    //   question: 'Pertanyaan 5',
    //   answer: 'Jawaban 5',
    // ),
    // Tambahkan lebih banyak item FAQ di sini jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height *
            0.5, // Tinggi minimum panel saat terlipat
        maxHeight: MediaQuery.of(context).size.height *
            0.8, // Tinggi maksimum panel saat terbuka
        defaultPanelState:
            PanelState.OPEN, // Panel akan terbuka saat pertama kali dibuka
        body: Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/dami.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context)
                .size
                .width, // Sesuaikan dengan kebutuhan Anda
          ),
        ), // Rounded corners untuk panel
        panel: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              color: Color(0xFF1D3557),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'SELAMAT DATANG',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Deskripsi halaman...',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  firebaseUIButton(context, "Masuk", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  }),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Belum Punya Akun?',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Card(
                            color: Color(0xFFFFB703),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/dami.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Daftar sebagai\nlender',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 24), // Jarak antara card
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Card(
                            color: Color(0xFFFFB703),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/dami.png'),
                                    radius: 30,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Daftar sebagai\nborrower',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
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
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'FAQ',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      faqItems.length,
                      (index) => FAQItemCard(faqItems[index]),
                    ),
                  ),
                  // ...Tambahkan lebih banyak widget sesuai kebutuhan Anda
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FAQItemCard extends StatefulWidget {
  final FaqItem faqItem;

  const FAQItemCard(this.faqItem);

  @override
  _FAQItemCardState createState() => _FAQItemCardState();
}

class _FAQItemCardState extends State<FAQItemCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          widget.faqItem.question,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFB703)),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.faqItem.answer,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
