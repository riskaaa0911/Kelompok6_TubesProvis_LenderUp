import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaksi with ChangeNotifier {
  List<Map<String, dynamic>> _transaksiData = [];

  List<Map<String, dynamic>> get transaksiData => _transaksiData;

  Future<void> fetchTransaksi(_dompetData) async {
    final url = Uri.parse(
        'http://localhost:8000/tampil_semua_transaksi/${_dompetData?["data"]['id_dompet']}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null) {
        _transaksiData = List<Map<String, dynamic>>.from(data['data']);
        // print(pinjamanData); // Cetak isi data pinjaman
      } else {
        // Error handling jika data tidak tersedia
        print('Data pinjaman tidak tersedia.');
      }
      print(_transaksiData);
      notifyListeners();
    } else {
      // Handle error response
    }
  }

  void updateTransaksi(List<Map<String, dynamic>> newTransaksiData) {
    _transaksiData = newTransaksiData;
    notifyListeners();
  }
}
