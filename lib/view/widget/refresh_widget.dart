import 'package:flutter/material.dart';

/// widget yang digunakan untuk refresh widget custom_future_builder ketika gagal meload data
class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    super.key,
    required this.action,
    this.width = 100,
    this.height = 40,
  });
  final Function() action;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: const Material(
        color: Color(0x66000000),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Gagal meload data!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
