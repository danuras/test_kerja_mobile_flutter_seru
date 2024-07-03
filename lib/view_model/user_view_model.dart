import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:test_kerja_screen_wizard/model/user_model.dart';

/// ViewModel untuk mengelola data pengguna.
class UserViewModel {
  final String apiUrl =
      'https://api.example.com/register'; // Ganti dengan URL API Anda

  /// Mengirim permintaan HTTP untuk mendaftarkan pengguna.
  Future<bool> registerUser(UserModel user) async {
    try {
      var uri = Uri.parse(apiUrl);
      var request = http.MultipartRequest("POST", uri);
      request.fields['first_name'] = user.firstName;
      request.fields['last_name'] = user.lastName;
      request.fields['bio_data'] = user.bioData;
      request.fields['province'] = user.province.toString();
      request.fields['city'] = user.city.toString();
      request.fields['district'] = user.district.toString();
      request.fields['village'] = user.village.toString();

      if (user.selfie != null) {
        var streamPp =
            http.ByteStream.fromBytes(await user.selfie!.readAsBytes());
        var lengthPp = await user.selfie!.length();
        var multipartFile = http.MultipartFile(
          'selfie',
          streamPp,
          lengthPp,
          filename: p.basename(user.selfie!.path),
        );

        request.files.add(multipartFile);
      }
      if (user.ktp != null) {
        var streamPp = http.ByteStream.fromBytes(await user.ktp!.readAsBytes());
        var lengthPp = await user.ktp!.length();
        var multipartFile = http.MultipartFile(
          'ktp',
          streamPp,
          lengthPp,
          filename: p.basename(user.ktp!.path),
        );

        request.files.add(multipartFile);
      }
      if (user.bebas != null) {
        var streamPp =
            http.ByteStream.fromBytes(await user.bebas!.readAsBytes());
        var lengthPp = await user.bebas!.length();
        var multipartFile = http.MultipartFile(
          'bebas',
          streamPp,
          lengthPp,
          filename: p.basename(user.bebas!.path),
        );

        request.files.add(multipartFile);
      }
      debugPrint(request.fields.toString());
      debugPrint('Jumlah file: ${request.files.length}');
      //var hasil = await request.send();
      // send
      //http.Response response = await http.Response.fromStream(hasil);

      /* if (response.statusCode == 200) {
        // Berhasil mendaftar
        return true;
      } else {
        // Gagal mendaftar
        return false;
      } */
      return true;
    } catch (e) {
      return false;
    }
  }
}
