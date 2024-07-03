import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:test_kerja_screen_wizard/model/user_model.dart';
import 'package:test_kerja_screen_wizard/view/widget/button/wizard_button.dart';
import 'package:test_kerja_screen_wizard/view/widget/input/custom_image_input.dart';

/// wizard 2 untuk menginputkan data diri user yang bersifat gambar
class Wizard2 extends StatefulWidget {
  const Wizard2({
    super.key,
    required this.userModel,
    required this.backAction,
    required this.nextAction,
  });
  final UserModel userModel;
  final Function() backAction, nextAction;

  @override
  State<Wizard2> createState() => _Wizard2State();
}

class _Wizard2State extends State<Wizard2> {
  File? selfie, ktp, bebas;
  final ValueNotifier<String?> selfieError = ValueNotifier(null);
  final ValueNotifier<String?> ktpError = ValueNotifier(null);
  final ValueNotifier<String?> bebasError = ValueNotifier(null);

  @override
  void initState() {
    selfie = widget.userModel.selfie;
    ktp = widget.userModel.ktp;
    bebas = widget.userModel.bebas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomImageInput(
          isRequired: true,
          action: (out, imageName) async {
            selfie = out;
            widget.userModel.selfie = selfie;
            widget.userModel.selfieName = imageName;
            return true;
          },
          deleteImage: () {
            widget.userModel.selfie = null;
            widget.userModel.selfieName = null;
          },
          imageName: widget.userModel.selfieName,
          imageError: selfieError,
          image: selfie,
          hint: 'Upload foto selfie',
          label: 'Foto Selfie',
        ),
        CustomImageInput(
          isRequired: true,
          action: (out, imageName) async {
            ktpError.value = null;
            if (await detectTextFromImage(out.path)) {
              ktp = out;
              widget.userModel.ktp = ktp;
              widget.userModel.ktpName = imageName;
              return true;
            } else {
              ktp = null;
              return false;
            }
          },
          deleteImage: () {
            widget.userModel.ktp = null;
            widget.userModel.ktpName = null;
          },
          imageName: widget.userModel.ktpName,
          imageError: ktpError,
          image: ktp,
          hint: 'Upload foto ktp',
          label: 'Foto Ktp',
        ),
        CustomImageInput(
          isRequired: true,
          action: (out, imageName) async {
            bebas = out;
            widget.userModel.bebas = bebas;
            widget.userModel.bebasName = imageName;
            return true;
          },
          deleteImage: () {
            widget.userModel.bebas = null;
            widget.userModel.bebasName = null;
          },
          imageName: widget.userModel.bebasName,
          imageError: bebasError,
          image: bebas,
          hint: 'Upload foto bebas',
          label: 'Foto Bebas',
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: WizardButton(
            isFirst: false,
            isLast: false,
            backAction: widget.backAction,
            nextAction: () {
              resetError();
              if (validate()) {
                widget.nextAction();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<bool> detectTextFromImage(String imagePath) async {
    String nik = '';
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      InputImage.fromFilePath(imagePath),
    );
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          if (isNik(element.text)) {
            nik = element.text;
            break;
          }
        }
      }
    }
    if (nik.isNotEmpty) {
      widget.userModel.nikKtp = nik;
      return true;
    } else {
      ktpError.value = 'Gambar ktp tidak bisa terbaca';
      return false;
    }
  }

  bool isNik(String text) {
    final nikRegex = RegExp(r'^\d{16}$');
    return nikRegex.hasMatch(text);
  }

  void resetError() {
    selfieError.value = null;
    ktpError.value = null;
    bebasError.value = null;
  }

  bool validate() {
    bool isValidate = true;
    if (selfie == null) {
      selfieError.value = 'Foto selfie tidak boleh kosong';
      isValidate = false;
    }
    if (ktp == null) {
      ktpError.value = 'Foto ktp tidak boleh kosong';
      isValidate = false;
    }
    if (bebas == null) {
      bebasError.value = 'Foto bebas tidak boleh kosong';
      isValidate = false;
    }
    return isValidate;
  }
}
