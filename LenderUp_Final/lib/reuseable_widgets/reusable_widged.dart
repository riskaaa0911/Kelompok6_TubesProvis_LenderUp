import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

// done
TextField reusableTextField(
    String text, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
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

Container UIButton(BuildContext context, String title, Function onTap) {
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

// done
AppBar buildProfileAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Color(0xffFFB703),
    title: Text(title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Color(0xff1D3557),
                fontSize: 18,
                fontWeight: FontWeight.w600))),
    // actions: [
    //   IconButton(
    //     icon: Icon(Icons.person),
    //     color: Color(0xff1d3557),
    //     onPressed: () {
    //       // Handle the action when the person icon is pressed
    //       // For example, navigate to another screen or show a menu
    //     },
    //   ),
    // ],
  );
}

// done
FractionallySizedBox reusableButton(
    String text, bool arrow, BuildContext context, Function onTap) {
  return FractionallySizedBox(
    widthFactor: 1.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
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
              child: Text(text,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0xff1D3557),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ))),
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

// done
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
                Text("Bank Mandiri",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("Nama Pemilik Akun",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontSize: 8,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("No. Rekening",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontSize: 8,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ))),
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
