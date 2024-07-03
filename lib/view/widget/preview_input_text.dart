import 'package:flutter/material.dart';

/// widget yang digunakan untuk preview text yang telah diinputkan
class PreviewInputText extends StatelessWidget {
  const PreviewInputText({
    super.key,
    required this.label,
    required this.input,
  });
  final String label, input;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          input,
          style: const TextStyle(
            color: Color(0xff999999),
          ),
        ),
      ],
    );
  }
}
