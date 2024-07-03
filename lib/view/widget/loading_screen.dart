import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// widget yang dapat digunakan ketika loading widget future builder sebelum mendapatkan data dari internet/api
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 50,
      child: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
