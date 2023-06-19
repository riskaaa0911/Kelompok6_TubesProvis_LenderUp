import 'package:flutter/material.dart';
import 'package:lender_up_19/reuseable_widgets/reusable_widged.dart';
import 'package:lender_up_19/screens/landing_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String accessToken;
  const ProfileScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = Uri.parse('http://localhost:8000/user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      setState(() {
        _userData = userData;
      });
      print(userData); // Mencetak data pengguna ke konsol
    } else {
      // Handle error response
    }
  }

  void _logout() {
    // Hapus akses token di sini
    // ...
    _clearToken(); // Memanggil fungsi untuk menghapus token
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
    );
  }

  void _clearToken() async {
    final url = Uri.parse('http://localhost:8000/logout');
    await http.post(
      url,
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
    );
    print("logout berhasil");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(children: [
          SizedBox(height: 30.0),
          CircleAvatar(
            radius: 100.0,
            backgroundImage: NetworkImage(
                "https://mir-s3-cdn-cf.behance.net/projects/404/12ed31104606189.Y3JvcCwzOTk5LDMxMjgsMCw5NDA.png"),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text('User Profile',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                reusableButton("Edit Profile", true, context, () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditProfile(accessToken: widget.accessToken);
                  }));
                }),
                reusableButton("Akun Bank", true, context, () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AkunBank();
                  }));
                }),
                reusableButton("Pengaturan", true, context, () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Setting();
                  }));
                }),
                reusableButton("Keluar", false, context, _logout),
                //reusableButton(),
                //ProfileOptionButton(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final String accessToken;
  const EditProfile({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = Uri.parse('http://localhost:8000/user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      setState(() {
        _userData = userData;
      });
      print(userData); // Mencetak data pengguna ke konsol
    } else {
      // Handle error response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "PROFIL"),
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(children: [
          SizedBox(height: 30.0),
          CircleAvatar(
            radius: 100.0,
            backgroundImage: NetworkImage(
                "https://mir-s3-cdn-cf.behance.net/projects/404/12ed31104606189.Y3JvcCwzOTk5LDMxMjgsMCw5NDA.png"),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text('User Profile',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                reusableButton("Nama ${_userData?["username"]}", true, context,
                    () {
                  return 0;
                }),
                reusableButton("Email ${_userData?["email"]}", true, context,
                    () {
                  return 0;
                }),
                reusableButton(
                    "Nomor Telepon ${_userData?["no_tlp"]}", true, context, () {
                  return 0;
                }),
                //reusableButton(),
                //ProfileOptionButton(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB703),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
              child: Text("Edit Profil",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0XFF1D3557),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
            ),
          ),
        ]),
      ),
    );
  }
}

class AkunBank extends StatefulWidget {
  const AkunBank({Key? key}) : super(key: key);

  @override
  State<AkunBank> createState() => _AkunBankState();
}

class _AkunBankState extends State<AkunBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "BANK"),
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(children: [
          SizedBox(
            height: 20.0,
          ),
          Row(children: [
            Text("AKUN BANK",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              Icons.more_vert_outlined,
              size: 20.0,
              color: Colors.white,
            )
          ]),
          SizedBox(
            height: 20.0,
          ),
          AkunBankCard(context),
          SizedBox(
            height: 20.0,
          ),
          AkunBankCard(context),
          SizedBox(
            height: 20.0,
          ),
          AkunBankCard(context),
          SizedBox(
            height: 20.0,
          ),
          AkunBankCard(context),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBank()),
                );
              },
              child: Text("Tambah Akun",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0xffFFB703),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
            ),
          ),
        ]),
      ),
    );
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "PENGATURAN"),
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(children: [
          SizedBox(height: 30.0),
          Row(children: [
            Text("PENGATURAN",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              Icons.more_vert_outlined,
              size: 20.0,
              color: Colors.white,
            )
          ]),
          SizedBox(
            height: 20.0,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 1.0,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //   child: Column(
          //     children: [
          //       reusableButton("Ubah Password", true, context, () {
          //         return Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => ChangePassword()));
          //       }),
          //       reusableButton("Hapus Akun", true, context, () {
          //         _showDeleteAccountBottomSheet(context);
          //       }),
          //       reusableButton("Placeholder", true, context, () {
          //         return 0;
          //       }),
          //       reusableButton("Placeholder", true, context, () {
          //         return 0;
          //       }),
          //       //reusableButton(),
          //       //ProfileOptionButton(),
          //     ],
          //   ),
          // ),
        ]),
      ),
    );
  }
}

class AddBank extends StatefulWidget {
  const AddBank({Key? key}) : super(key: key);

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  final _formKey = GlobalKey<FormState>();
  String _namaBank = '';
  String _noRekBank = '';

  List<String> _bankOption = [
    'Bank BCA',
    'Bank BRI',
    'Bank BJB',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "BANK"),
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(children: [
          SizedBox(height: 30.0),
          Row(children: [
            Text("TAMBAHKAN AKUN BANK",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ))),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              Icons.more_vert_outlined,
              size: 20.0,
              color: Colors.white,
            )
          ]),
          SizedBox(
            height: 40.0,
          ),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Nama Bank",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 47.5,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    fillColor: Colors.white.withOpacity(0.3),
                    filled: true,
                  ),
                  value: _namaBank.isNotEmpty ? _namaBank : _bankOption[0],
                  onChanged: (value) {
                    setState(() {
                      _namaBank = value!;
                    });
                  },
                  dropdownColor: Color(0xFF1D3557),
                  items: _bankOption.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            // color: Colors.white,withOpacity,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ))),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("No Rekening",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ))),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 47.5,
                      child: TextFormField(
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            labelText: 'Masukkan Nomor Rekening',
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter account number';
                            }
                            return null;
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    height: 47.5,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB703),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text("Periksa",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0XFF1D3557),
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 47.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB703),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text("Tambahkan",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0XFF1D3557),
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String _passLama = '';
  String _passBaru = '';
  String _retypePassBaru = '';

  bool _isPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildProfileAppBar(context, "PENGATURAN"),
      backgroundColor: Color(0xFF1D3557),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.width * 0.2,
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.width * 0.1),
        child: ListView(children: [
          SizedBox(height: 30.0),
          Text("Ubah Password",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ))),
          SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 47.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Masukkan Password lama',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Password lama';
                    } // Perform validation against the actual old password
                    else if (value != 'oldPassword') {
                      return 'Password lama salah';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _passLama = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Pastikan Password terdiri dari huruf dan angka",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
              SizedBox(
                height: 5.0,
              ),
              Text("Password Minimal 8 karakter",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ))),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 47.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Masukkan Password baru',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Password baru';
                    } else if (!_isPasswordValid) {
                      return 'Password baru harus terdiri dari huruf dan angka dan minimal 8 karakter';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _passBaru = value;
                      _validatePassword();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 47.5,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Masukkan Password baru',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Password baru';
                    } else if (value != _passBaru) {
                      return 'Password tidak sesuai';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _retypePassBaru = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 47.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform password update logic here
                        print('Password changed successfully');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB703),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text("Ubah Password",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0XFF1D3557),
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }

  void _validatePassword() {
    // Check if the new password meets the requirements
    // At least 8 characters and contains both letters and numbers
    RegExp passwordValidationRegex =
        RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,}$');
    _isPasswordValid = passwordValidationRegex.hasMatch(_passBaru);
  }
}

void _showDeleteAccountBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFB703),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("Anda Yakin Untuk",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0XFF1D3557),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                    Text("Menghapus Akun?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Color(0XFF1D3557),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ))),
                    SizedBox(
                      height: 40.0,
                    ),
                    Icon(
                      Icons.question_mark_rounded,
                      size: 90.0,
                      color: Color(0xFF1D3557),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1D3557),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text("Batal",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ))),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.075,
                  ),
                  Container(
                    width: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Perform account deletion logic here
                        print("Account deleted");
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1D3557),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text("Hapus",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
