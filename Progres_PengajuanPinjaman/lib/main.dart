import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    FormPage1(),
    TandaTanganPage(),
    LoanFormPage(),
    SuccessPage(),
  ];

  final _formKey = GlobalKey<FormState>();

  void _navigateToPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  Widget _buildPageIndicator(int pageIndex) {
    String pageName = '';
    switch (pageIndex) {
      case 0:
        pageName = 'Nama UMKM';
        break;
      case 1:
        pageName = 'Tanda Tangan';
        break;
      case 2:
        pageName = 'Info Merchant';
        break;
      case 3:
        pageName = 'Berhasil';
        break;
    }

    bool isActive = _currentPageIndex == pageIndex;
    return GestureDetector(
      onTap: () {
        _navigateToPage(pageIndex);
      },
      child: Column(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isActive ? Color.fromARGB(255, 251, 191, 26) : Colors.white,
            ),
            child: Center(
              child: Text(
                '${pageIndex + 1}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? Color.fromARGB(255, 2, 56, 104)
                      : Color.fromARGB(255, 2, 56, 104),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            pageName,
            style: TextStyle(
              fontSize: 12.0,
              color: isActive ? Colors.white : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PENGAJUAN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 2, 56, 104),
      ),
      backgroundColor: Color.fromARGB(255, 2, 56, 104),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    _buildPageIndicator(i),
                ],
              ),
            ),
          ),
          Expanded(
            child: _pages[_currentPageIndex],
          ),
        ],
      ),
    );
  }
}

class FormPage1 extends StatefulWidget {
  @override
  _FormPage1State createState() => _FormPage1State();
}

class _FormPage1State extends State<FormPage1> {
  final _formKey = GlobalKey<FormState>();
  String _umkmName = '';
  String _umkmSector = '';
  String _businessDuration = '< 1 Tahun';
  String _umkmBenefit = '< 12.000.000';
  String _streetName = '';
  String _rtRw = '';
  String _posKode = '';
  String _neighborhood = '';
  String _district = '';
  String _city = '';

  List<String> _durationOptions = [
    '< 1 Tahun',
    '> 1 Tahun',
  ];

  List<String> _benefitOptions = [
    '< 12.000.000',
    '> 12.000.000',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, right: 50.0, left: 50.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama UMKM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama UMKM',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter UMKM name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _umkmName = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sektor UMKM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Sektor UMKM',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter UMKM sector';
                  }
                  return null;
                },
                onSaved: (value) {
                  _umkmSector = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lama Usaha Beroperasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  //labelText: 'Lama Usaha Beroperasi',
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: _businessDuration,
                onChanged: (value) {
                  setState(() {
                    _businessDuration = value!;
                  });
                },
                items: _durationOptions.map((duration) {
                  return DropdownMenuItem<String>(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keuntungan UMKM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  //labelText: 'Keuntungan UMKM',
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: _umkmBenefit,
                onChanged: (value) {
                  setState(() {
                    _umkmBenefit = value!;
                  });
                },
                items: _benefitOptions.map((benefit) {
                  return DropdownMenuItem<String>(
                    value: benefit,
                    child: Text(benefit),
                  );
                }).toList(),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Foto Produk atau Fasilitas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement photo selection logic
                  },
                  child: Text(
                    'Browse',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                        vertical: 22.0,
                        horizontal: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alamat Lengkap UMKM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Jalan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Jalan',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter street name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _streetName = value!;
                },
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RT/RW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kode Pos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'RT/RW',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter RT/RW';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rtRw = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Kode Pos',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter kode pos';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _posKode = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kelurahan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Kelurahan',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter neighborhood';
                  }
                  return null;
                },
                onSaved: (value) {
                  _neighborhood = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kecamatan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Kecamatan',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter district';
                  }
                  return null;
                },
                onSaved: (value) {
                  _district = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kota',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Masukkan Nama Kota',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
                onSaved: (value) {
                  _city = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Text(
                    'Selanjutnya',
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 56, 104),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('Nama UMKM: $_umkmName');
                      print('Sektor UMKM: $_umkmSector');
                      print('Lama Usaha Beroperasi: $_businessDuration');
                      print('Keuntungan UMKM: $_umkmBenefit');
                      print('Nama Jalan: $_streetName');
                      print('RT/RW: $_rtRw');
                      print('Kelurahan: $_neighborhood');
                      print('Kecamatan: $_district');
                      print('Kota: $_city');
                      final _homePageState =
                          context.findAncestorStateOfType<_HomePageState>();
                      _homePageState!._nextPage();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 251, 191, 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 70.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TandaTanganPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Upload Tanda Tangan',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          InkWell(
            onTap: () {
              // Handle the click event to add an image
            },
            child: Container(
              width: 250.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Browse',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          ElevatedButton(
            child: Text(
              'Selanjutnya',
              style: TextStyle(
                color: Color.fromARGB(255, 2, 56, 104),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              final _homePageState =
                  context.findAncestorStateOfType<_HomePageState>();
              _homePageState!._nextPage();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 251, 191, 26),
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
    );
  }
}

class LoanFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _loanAmount = 'RP. 15.000.000,-'; // Default loan amount
  String _loanTenure = '12 Bulan'; // Default loan tenure
  String _paymentAmount = 'Rp. 2.000.000,- /Bulan'; // Default payment amount

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100.0, left: 100.0, top: 10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jumlah Plafond Pinjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                ),
                initialValue: _loanAmount,
                enabled: false,
                onSaved: (value) {
                  _loanAmount = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tenor Pinjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                ),
                initialValue: _loanTenure,
                enabled: false,
                onSaved: (value) {
                  _loanTenure = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dana yang perlu dibayar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                ),
                initialValue: _paymentAmount,
                enabled: false,
                onSaved: (value) {
                  _paymentAmount = value!;
                },
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
                  child: Text(
                    'Selesai',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 56, 104),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('Loan Amount: $_loanAmount');
                      print('Loan Tenure: $_loanTenure');
                      print('Payment Amount: $_paymentAmount');
                      final _homePageState =
                          context.findAncestorStateOfType<_HomePageState>();
                      _homePageState!._nextPage();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 251, 191, 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 60.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Pengajuan Pinjaman Berhasil!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(height: 50.0),
          ElevatedButton(
            child: Text(
              'Lihat Pinjaman Saya',
              style: TextStyle(
                color: Color.fromARGB(255, 2, 56, 104),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              // Handle the "Selesai" button press
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 251, 191, 26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 60.0,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            child: Text(
              'Kembali',
              style: TextStyle(
                color: Color.fromARGB(255, 251, 191, 26),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              // Handle the "Kembali" button press
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 2, 56, 104),
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
    );
  }
}
