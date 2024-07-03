import 'dart:io';

/// Model data pengguna
class UserModel {
  final String firstName;
  final String lastName;
  final String bioData;
  final int province;
  final int city;
  final int district;
  final int village;
  String? nikKtp;
  File? selfie, ktp, bebas;
  String? selfieName, ktpName, bebasName;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.bioData,
    required this.province,
    required this.city,
    required this.district,
    required this.village,
  });

  /// Mengkonversi data pengguna ke format json
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'bio_data': bioData,
      'province': province,
      'city': city,
      'district': district,
      'village': village,
    };
  }
}
