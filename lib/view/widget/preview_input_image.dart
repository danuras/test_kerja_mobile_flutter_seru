import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/view/widget/image_detail.dart';

/// widget yang digunakan untuk preview gambar yang telah diinputkan
class PreviewInputImage extends StatelessWidget {
  const PreviewInputImage({
    super.key,
    required this.image,
    required this.imageName,
    required this.label,
  });
  final File image;
  final String imageName;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label :',
          style: const TextStyle(
            letterSpacing: 1,
            backgroundColor: Colors.transparent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ImageDetail(
                    name: imageName,
                    file: image,
                  );
                },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffaaaaaa),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  imageName,
                  style: const TextStyle(
                    color: Color(0xff999999),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
