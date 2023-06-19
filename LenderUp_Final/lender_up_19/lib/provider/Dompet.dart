import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dompet with ChangeNotifier {
  int _saldo = 0;

  int get saldo => _saldo;

  Future<void> fetchSaldo(userData) async {
    try {
      final url = Uri.parse('http://localhost:8000/dompet/${userData['ID']}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dompetData = jsonDecode(response.body);
        final saldo = dompetData['data']['saldo'];
        _saldo = saldo;
        print("saldo ${userData['ID']} ${saldo} ${_saldo}");
      } else {
        throw Exception('Failed to fetch saldo');
      }
    } catch (error) {
      throw Exception('Failed to fetch saldo: $error');
    } finally {
      notifyListeners();
    }
  }

  void updateSaldo(int newSaldo) {
    _saldo = newSaldo;
    notifyListeners();
  }
}
