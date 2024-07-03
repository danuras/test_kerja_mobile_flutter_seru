import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// widget yang dapat digunakan untuk melihat gambar
class ImageDetail extends StatelessWidget {
  const ImageDetail({
    required this.name,
    this.file,
    this.url,
    super.key,
  });
  final String name;
  final File? file;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            if (file != null) {
              return PhotoView(
                imageProvider: FileImage(
                  file!,
                ),
              );
            }
            return PhotoView(
              imageProvider: NetworkImage(
                url!,
              ),
            );
          },
        ),
      ),
    );
  }
}
