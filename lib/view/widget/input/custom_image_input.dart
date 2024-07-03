import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:test_kerja_screen_wizard/helper/pick_image.dart';
import 'package:test_kerja_screen_wizard/model/endpoint.dart';
import 'package:test_kerja_screen_wizard/view/widget/image_detail.dart';

/// widget yang dapat digunakan untuk menginputkan gambar
class CustomImageInput extends StatefulWidget {
  const CustomImageInput({
    super.key,
    required this.action,
    required this.imageError,
    required this.deleteImage,
    required this.hint,
    required this.label,
    this.isRequired = false,
    this.width = 300,
    this.height,
    this.image,
    this.imageUrl,
    this.imageName,
  });
  final bool isRequired;
  final String? imageUrl;
  final String? imageName;
  final File? image;
  final double width;
  final double? height;
  final ValueNotifier<String?> imageError;
  final Future<bool> Function(File image, String imageName) action;
  final Function() deleteImage;
  final String hint, label;

  @override
  State<CustomImageInput> createState() => _CustomImageInputState();
}

class _CustomImageInputState extends State<CustomImageInput> {
  String imagePath = '';
  String? imageUrl;
  String imageName = '';
  File? image;
  ValueNotifier<bool> refreshInput = ValueNotifier(false);

  @override
  void initState() {
    image = widget.image;
    imageUrl = widget.imageUrl;
    imageName = widget.imageName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        top: 8.0,
        bottom: 8.0,
        right: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: const TextStyle(
                    letterSpacing: 1,
                    color: Color(0xff999999),
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.w400,
                  ),
                  children: (widget.isRequired)
                      ? [
                          const TextSpan(
                            text: '*',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      : [],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: refreshInput,
            builder: (context, ri, child) {
              return GestureDetector(
                onTap: () async {
                  await PickImage.pickImage().then(
                    (result) async {
                      if (result != null) {
                        imagePath = result.files.single.path!;
                        image = File(imagePath);
                        imageName = path.basename(imagePath);
                        await widget
                            .action(
                          image!,
                          imageName,
                        )
                            .then((bool value) {
                          if (!value) {
                            image = null;
                          }
                        });
                        refreshInput.value = !refreshInput.value;
                      }
                    },
                  );
                },
                child: Builder(
                  builder: (context) {
                    if ((imageUrl == null || imageUrl == '') && image == null) {
                      return DottedBorder(
                        color: const Color(0xff999999),
                        strokeWidth: 2,
                        radius: const Radius.circular(10),
                        dashPattern: const [7, 7, 7],
                        borderType: BorderType.RRect,
                        child: SizedBox(
                          height: (widget.height == null)
                              ? maxWidth * 2 / 5
                              : widget.height,
                          width: maxWidth,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: const Color(0xff666666),
                                  size: maxWidth / 5,
                                ),
                                Text(
                                  widget.hint,
                                  style: const TextStyle(
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Material(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: SizedBox(
                          height: (widget.height == null)
                              ? maxWidth * 2 / 5
                              : widget.height,
                          width: maxWidth,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Builder(
                                  builder: (context) {
                                    if (image == null) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ImageDetail(
                                                  name: imageName,
                                                  url: EndPoint.asset +
                                                      imageUrl!,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          child: Image.network(
                                            EndPoint.asset + imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ImageDetail(
                                                  name: imageName,
                                                  file: image!,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          child: Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: const Text(
                                              'Anda yakin ingin menghapus gambar ini?',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  'Tidak',
                                                  style: TextStyle(
                                                    color: Color(0xff8d9de8),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  image = null;
                                                  imageUrl = null;
                                                  refreshInput.value =
                                                      !refreshInput.value;
                                                  widget.deleteImage();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Ya',
                                                  style: TextStyle(
                                                    color: Color(0xff8d9de8),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: const Material(
                                        color: Color(0x88ff0000),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Color(0xaaffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ValueListenableBuilder(
              valueListenable: widget.imageError,
              builder: (context, ie, child) {
                if (ie != null) {
                  return Text(
                    ie,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
