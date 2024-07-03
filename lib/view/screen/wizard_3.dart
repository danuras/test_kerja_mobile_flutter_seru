import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/model/user_model.dart';
import 'package:test_kerja_screen_wizard/view/widget/button/wizard_button.dart';
import 'package:test_kerja_screen_wizard/view/widget/preview_input_image.dart';
import 'package:test_kerja_screen_wizard/view/widget/preview_input_text.dart';
import 'package:test_kerja_screen_wizard/view_model/region_view_model.dart';

/// wizard 3 untuk mengkonfirmasi inputan user
class Wizard3 extends StatefulWidget {
  const Wizard3({
    super.key,
    required this.rvm,
    required this.backAction,
    required this.save,
    required this.userModel,
  });
  final RegionViewModel rvm;
  final Function() backAction, save;
  final UserModel userModel;

  @override
  State<Wizard3> createState() => _Wizard3State();
}

class _Wizard3State extends State<Wizard3> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Apakah data yang anda masukan sudah benar?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffdddddd),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                PreviewInputText(
                  label: 'Nama Depan',
                  input: widget.userModel.firstName,
                ),
                PreviewInputText(
                  label: 'Nama Belakang',
                  input: widget.userModel.lastName,
                ),
                PreviewInputText(
                  label: 'Bio Data',
                  input: widget.userModel.bioData,
                ),
                PreviewInputText(
                  label: 'Provinsi',
                  input: widget.rvm.provinces[widget.userModel.province]
                      ['name'],
                ),
                PreviewInputText(
                  label: 'Kota',
                  input: widget.rvm.cities[widget.userModel.city]['name'],
                ),
                PreviewInputText(
                  label: 'Kecamatan',
                  input: widget.rvm.districts[widget.userModel.district]
                      ['name'],
                ),
                PreviewInputText(
                  label: 'Kelurahan',
                  input: widget.rvm.villages[widget.userModel.village]['name'],
                ),
                PreviewInputText(
                  label: 'Nik Ktp',
                  input: widget.userModel.nikKtp!,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PreviewInputImage(
                image: widget.userModel.selfie!,
                imageName: widget.userModel.selfieName!,
                label: 'Foto Selfie',
              ),
              const SizedBox(
                height: 10,
              ),
              PreviewInputImage(
                image: widget.userModel.ktp!,
                imageName: widget.userModel.ktpName!,
                label: 'Foto Ktp',
              ),
              const SizedBox(
                height: 10,
              ),
              PreviewInputImage(
                image: widget.userModel.bebas!,
                imageName: widget.userModel.bebasName!,
                label: 'Foto Bebas',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: WizardButton(
            isFirst: false,
            isLast: true,
            backAction: widget.backAction,
            save: widget.save,
          ),
        ),
      ],
    );
  }
}
