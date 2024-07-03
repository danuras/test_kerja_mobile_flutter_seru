import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/model/user_model.dart';
import 'package:test_kerja_screen_wizard/view/screen/wizard_1.dart';
import 'package:test_kerja_screen_wizard/view/screen/wizard_2.dart';
import 'package:test_kerja_screen_wizard/view/screen/wizard_3.dart';
import 'package:test_kerja_screen_wizard/view_model/region_view_model.dart';
import 'package:test_kerja_screen_wizard/view_model/user_view_model.dart';

/// Halaman untuk mendaftarkan pengguna
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final selectedPage = ValueNotifier(0);
  late List<Widget?> pages;
  final RegionViewModel rvm = RegionViewModel();
  final uvm = UserViewModel();
  UserModel? userModel;
  List<String> provinces = ['Jawa Barat', 'Jawa Tengah', 'Jawa Barat'];
  @override
  void initState() {
    pages = [
      null,
      null,
      null,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(141, 157, 232, 1),
          elevation: 4,
          title: const Text(
            'Pendaftaran Akun',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: selectedPage,
          builder: (context, sp, child) {
            if (sp == 0) {
              if (pages[0] == null) {
                pages[0] = Wizard1(
                  userModel: userModel,
                  nextAction: (output) {
                    userModel = output;
                    selectedPage.value++;
                  },
                  rvm: rvm,
                );
              }
              return Wizard1(
                userModel: userModel,
                nextAction: (output) {
                  userModel = output;
                  selectedPage.value++;
                },
                rvm: rvm,
              );
            } else if (sp == 1) {
              if (pages[1] == null) {
                pages[1] = Wizard2(
                  userModel: userModel!,
                  backAction: () {
                    selectedPage.value--;
                  },
                  nextAction: () {
                    selectedPage.value++;
                  },
                );
              }
              return pages[1]!;
            } else {
              if (pages[2] == null) {
                pages[2] = Wizard3(
                  rvm: rvm,
                  backAction: () {
                    selectedPage.value--;
                  },
                  save: () async {
                    await uvm.registerUser(userModel!);
                  },
                  userModel: userModel!,
                );
              }
              return pages[2]!;
            }
          },
        ),
      ),
    );
  }
}
