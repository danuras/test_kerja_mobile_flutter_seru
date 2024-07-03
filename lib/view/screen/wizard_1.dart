import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/model/user_model.dart';
import 'package:test_kerja_screen_wizard/view/widget/button/wizard_button.dart';
import 'package:test_kerja_screen_wizard/view/widget/custom_future_builder.dart';
import 'package:test_kerja_screen_wizard/view/widget/input/custom_dropdown_input.dart';
import 'package:test_kerja_screen_wizard/view/widget/input/custom_text_field.dart';
import 'package:test_kerja_screen_wizard/view_model/region_view_model.dart';

/// wizard 1 untuk menginputkan data diri user yang bersifat text
class Wizard1 extends StatefulWidget {
  const Wizard1({
    super.key,
    required this.nextAction,
    required this.rvm,
    required this.userModel,
  });
  final UserModel? userModel;
  final RegionViewModel rvm;
  final Function(UserModel userModel) nextAction;

  @override
  State<Wizard1> createState() => _Wizard1State();
}

class _Wizard1State extends State<Wizard1> {
  late Future<List<dynamic>?> funcProvince, funcCity, funcDistrict, funcVillage;
  bool isFirst = true;

  final TextEditingController firstName = TextEditingController(text: '');
  final TextEditingController lastName = TextEditingController(text: '');
  final TextEditingController bioData = TextEditingController(text: '');
  ValueNotifier<int?> selectedProvince = ValueNotifier(null);
  ValueNotifier<int?> selectedCity = ValueNotifier(null);
  ValueNotifier<int?> selectedDistrict = ValueNotifier(null);
  ValueNotifier<int?> selectedVillage = ValueNotifier(null);

  final ValueNotifier<String?> errorFirstName = ValueNotifier(null);
  final ValueNotifier<String?> errorLastName = ValueNotifier(null);
  final ValueNotifier<String?> errorBioData = ValueNotifier(null);
  final ValueNotifier<String?> errorSelectedProvince = ValueNotifier(null);
  final ValueNotifier<String?> errorSelectedCity = ValueNotifier(null);
  final ValueNotifier<String?> errorSelectedDistrict = ValueNotifier(null);
  final ValueNotifier<String?> errorSelectedVillage = ValueNotifier(null);

  @override
  void initState() {
    isFirst = true;
    if (widget.userModel != null) {
      firstName.text = widget.userModel!.firstName;
      lastName.text = widget.userModel!.lastName;
      bioData.text = widget.userModel!.bioData;
      selectedProvince = ValueNotifier(widget.userModel!.province);
      selectedCity = ValueNotifier(widget.userModel!.city);
      selectedDistrict = ValueNotifier(widget.userModel!.district);
      selectedVillage = ValueNotifier(widget.userModel!.village);
    }
    funcProvince = widget.rvm.getProvinces();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                Text(
                  'Masukan data diri anda',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CustomTextField(
                  labelText: 'Nama Depan',
                  isRequired: true,
                  errorText: errorFirstName,
                  controller: firstName,
                ),
                const SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  labelText: 'Nama Belakang',
                  isRequired: true,
                  errorText: errorLastName,
                  controller: lastName,
                ),
                const SizedBox(
                  height: 3,
                ),
                CustomTextField(
                  labelText: 'Bio Data',
                  isRequired: true,
                  errorText: errorBioData,
                  controller: bioData,
                ),
                const SizedBox(
                  height: 3,
                ),
                CustomFutureBuilder(
                  future: funcProvince,
                  widgetResult: (result) {
                    widget.rvm.provinces = result!;

                    return CustomDropdownInput(
                      hint: 'Provinsi',
                      errorText: errorSelectedProvince,
                      items: List.generate(
                        widget.rvm.provinces.length,
                        (idx) => widget.rvm.provinces[idx]['name'],
                      ),
                      onBeforeChange: (a, b) async {
                        selectedCity.value = null;
                        widget.rvm.cities = [];
                        selectedDistrict.value = null;
                        widget.rvm.districts = [];
                        selectedVillage.value = null;
                        widget.rvm.villages = [];
                        return true;
                      },
                      selectedIndex: selectedProvince,
                    );
                  },
                  refreshWidget: () {
                    funcProvince = widget.rvm.getProvinces();
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 3,
                ),
                ValueListenableBuilder(
                  valueListenable: selectedProvince,
                  builder: (context, sp, child) {
                    if (sp != null) {
                      funcCity =
                          widget.rvm.getCities(widget.rvm.provinces[sp]['id']);
                      return CustomFutureBuilder(
                        future: funcCity,
                        widgetResult: (result) {
                          widget.rvm.cities = result!;
                          return CustomDropdownInput(
                            hint: 'Kota',
                            errorText: errorSelectedCity,
                            items: List.generate(
                              widget.rvm.cities.length,
                              (idx) => widget.rvm.cities[idx]['name'],
                            ),
                            onBeforeChange: (a, b) async {
                              selectedDistrict.value = null;
                              widget.rvm.districts = [];
                              selectedVillage.value = null;
                              widget.rvm.villages = [];
                              return true;
                            },
                            selectedIndex: selectedCity,
                          );
                        },
                        refreshWidget: () {
                          funcCity = widget.rvm
                              .getCities(widget.rvm.provinces[sp]['id']);
                          setState(() {});
                        },
                      );
                    }
                    return CustomDropdownInput(
                      hint: 'Kota',
                      items: const [],
                      selectedIndex: selectedCity,
                      errorText: errorSelectedCity,
                      onBeforeChange: (a, b) async {
                        selectedDistrict.value = null;
                        widget.rvm.districts = [];
                        selectedVillage.value = null;
                        widget.rvm.villages = [];
                        return true;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 3,
                ),
                ValueListenableBuilder(
                  valueListenable: selectedCity,
                  builder: (context, sc, child) {
                    if (sc != null) {
                      funcDistrict = widget.rvm.getDistricts(
                        widget.rvm.cities[sc]['id'],
                      );
                      return CustomFutureBuilder(
                        future: funcDistrict,
                        widgetResult: (result) {
                          widget.rvm.districts = result!;
                          return CustomDropdownInput(
                            hint: 'Kecamatan',
                            errorText: errorSelectedDistrict,
                            items: List.generate(
                              widget.rvm.districts.length,
                              (idx) => widget.rvm.districts[idx]['name'],
                            ),
                            selectedIndex: selectedDistrict,
                            onBeforeChange: (a, b) async {
                              selectedVillage.value = null;
                              widget.rvm.villages = [];
                              return true;
                            },
                          );
                        },
                        refreshWidget: () {
                          funcDistrict = widget.rvm.getDistricts(
                            widget.rvm.cities[sc]['id'],
                          );
                          setState(() {});
                        },
                      );
                    }
                    return CustomDropdownInput(
                      hint: 'Kecamatan',
                      items: const [],
                      selectedIndex: selectedDistrict,
                      errorText: errorSelectedDistrict,
                      onBeforeChange: (a, b) async {
                        selectedVillage.value = null;
                        widget.rvm.villages = [];
                        return true;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 3,
                ),
                ValueListenableBuilder(
                  valueListenable: selectedDistrict,
                  builder: (context, sd, child) {
                    if (sd != null) {
                      funcVillage = widget.rvm
                          .getVillages(widget.rvm.districts[sd]['id']);
                      return CustomFutureBuilder(
                        future: funcVillage,
                        widgetResult: (result) {
                          widget.rvm.villages = result!;
                          return CustomDropdownInput(
                            hint: 'Kelurahan',
                            errorText: errorSelectedVillage,
                            items: List.generate(
                              widget.rvm.villages.length,
                              (idx) => widget.rvm.villages[idx]['name'],
                            ),
                            selectedIndex: selectedVillage,
                            onBeforeChange: (a, b) async {
                              return true;
                            },
                          );
                        },
                        refreshWidget: () {
                          funcVillage = widget.rvm.getVillages(
                            widget.rvm.districts[sd]['id'],
                          );
                          setState(() {});
                        },
                      );
                    }
                    return CustomDropdownInput(
                      hint: 'Kelurahan',
                      items: const [],
                      errorText: errorSelectedVillage,
                      selectedIndex: selectedVillage,
                      onBeforeChange: (a, b) async {
                        return true;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: WizardButton(
            isFirst: true,
            isLast: false,
            backAction: () {},
            nextAction: () {
              resetError();
              if (validateInput()) {
                widget.nextAction(UserModel(
                  firstName: firstName.text,
                  lastName: lastName.text,
                  bioData: bioData.text,
                  province: selectedProvince.value!,
                  city: selectedCity.value!,
                  district: selectedDistrict.value!,
                  village: selectedVillage.value!,
                ));
              }
            },
          ),
        ),
      ],
    );
  }

  void resetError() {
    errorFirstName.value = null;
    errorLastName.value = null;
    errorBioData.value = null;
    errorSelectedProvince.value = null;
    errorSelectedCity.value = null;
    errorSelectedDistrict.value = null;
    errorSelectedVillage.value = null;
  }

  bool validateInput() {
    bool isValidate = true;
    if (isEmptyOrNull(firstName.text)) {
      errorFirstName.value = 'Nama depan tidak boleh kosong';
      isValidate = false;
    }
    if (isEmptyOrNull(lastName.text)) {
      errorLastName.value = 'Nama belakang tidak boleh kosong';
      isValidate = false;
    }
    if (isEmptyOrNull(bioData.text)) {
      errorBioData.value = 'Bio data tidak boleh kosong';
      isValidate = false;
    }
    if (selectedProvince.value == null) {
      errorSelectedProvince.value = 'Provinsi tidak boleh kosong';
      isValidate = false;
    }
    if (selectedCity.value == null) {
      errorSelectedCity.value = 'Kota tidak boleh kosong';
      isValidate = false;
    }
    if (selectedDistrict.value == null) {
      errorSelectedDistrict.value = 'Kecamatan tidak boleh kosong';
      isValidate = false;
    }
    if (selectedVillage.value == null) {
      errorSelectedVillage.value = 'Desa tidak boleh kosong';
      isValidate = false;
    }
    return isValidate;
  }

  bool isEmptyOrNull(String input) {
    return !RegExp(r'^(?!\s*$).+').hasMatch(input);
  }
}
