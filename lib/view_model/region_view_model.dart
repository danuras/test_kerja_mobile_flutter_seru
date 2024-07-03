import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

/// ViewModel untuk mendapatkan data daerah
class RegionViewModel {
  List<dynamic> provinces = [], cities = [], districts = [], villages = [];

  final String baseURL =
      'http://www.emsifa.com/api-wilayah-indonesia/api'; // Ganti dengan URL API Anda

  /// Mengirim permintaan HTTP untuk mendapatkan data provinsi
  Future<List<dynamic>?> getProvinces() async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/provinces.json'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        // Gagal mendaftar
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Mengirim permintaan HTTP untuk mendapatkan data kota
  Future<List<dynamic>?> getCities(String provinceId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/regencies/$provinceId.json'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        // Gagal mendaftar
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Mengirim permintaan HTTP untuk mendapatkan data kecamatan
  Future<List<dynamic>?> getDistricts(String cityId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/districts/$cityId.json'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        // Gagal mendaftar
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Mengirim permintaan HTTP untuk mendapatkan data kelurahan
  Future<List<dynamic>?> getVillages(String districtId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/villages/$districtId.json'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        return result;
      } else {
        // Gagal mendaftar
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
