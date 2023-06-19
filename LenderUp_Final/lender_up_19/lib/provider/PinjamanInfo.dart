import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class PinjamanInfo extends ChangeNotifier {
  List<Map<String, dynamic>> pinjamanDataDidanai = [];
  int totalMitra = 0;
  double totalAset = 0;
  double totalProfit = 0;
  double totalSisaPokok = 0;
  double totalBagiHasil = 0;
  double totalAngsuran = 0;
  String jatuhtempo = '';

  Future<void> getPinjamanDataDidanai(int id_borrower) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:8000/tampil_semua_pinjaman_borrower/${id_borrower}',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          pinjamanDataDidanai = List<Map<String, dynamic>>.from(data['data']);
          // Perform calculations and update values
          totalMitra = 0;
          totalAset = 0;
          totalProfit = 0;
          totalSisaPokok = 0;
          totalBagiHasil = 0;
          totalAngsuran = 0;
          jatuhtempo = '';

          for (var pinjaman in pinjamanDataDidanai) {
            if (pinjaman['status'] == 'didanai') {
              totalMitra++;
              totalAset +=
                  pinjaman['nominal_pinjaman'] + pinjaman['bagi_hasil_jmlh'];
              totalProfit += pinjaman['bagi_hasil_jmlh'];
              totalSisaPokok += pinjaman['nominal_pinjaman'] +
                  pinjaman['bagi_hasil_jmlh'] -
                  pinjaman["nominal_dilunasi"];
              totalBagiHasil += pinjaman['bagi_hasil_jmlh'];
              totalAngsuran += pinjaman['jumlah_angsuran'];
              jatuhtempo = pinjaman['tanggal_jatuh_tempo'];
            }
          }

          // Notify listeners of the data changes
          notifyListeners();
        } else {
          print('Data pinjaman tidak tersedia.');
        }
      } else {
        print('Terjadi kesalahan. Kode respons: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }
}
