import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

/// widget dropdown yang dapat digunakan untuk menginputkan alamat
class CustomDropdownInput extends StatelessWidget {
  const CustomDropdownInput({
    super.key,
    required this.hint,
    required this.items,
    required this.selectedIndex,
    this.isRequired = true,
    required this.errorText,
    required this.onBeforeChange,
  });
  final String hint;
  final bool isRequired;
  final List<String> items;
  final ValueNotifier<int?> selectedIndex;
  final ValueNotifier errorText;
  final Future<bool?> Function(String?, String?)? onBeforeChange;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: errorText,
        builder: (context, error, child) {
          return ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, sv, child) {
              return DropdownSearch<String>(
                onBeforeChange: onBeforeChange,
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  showSearchBox: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                  menuProps: const MenuProps(
                    backgroundColor:
                        Colors.white, // Mengubah warna background popup
                  ),
                  emptyBuilder: (context, searchEntry) {
                    return const Center(
                      child: Text(
                        'Data tidak ditemukan', // Teks kustom ketika tidak ada data
                      ),
                    );
                  },
                  searchFieldProps: const TextFieldProps(
                    cursorColor: Color.fromRGBO(141, 157, 232, 1),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(141, 157, 232, 1),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(141, 157, 232, 1),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                items: items,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(
                    color: Color(0xff999999),
                    height: 2.5,
                  ),
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    label: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: hint,
                            style: const TextStyle(
                              letterSpacing: 1,
                              color: Color(0xff999999),
                              backgroundColor: Colors.transparent,
                              fontWeight: FontWeight.w400,
                            ),
                            children: (isRequired)
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
                      ],
                    ),
                    suffixIconColor: (error != null)
                        ? Colors.red
                        : const Color.fromRGBO(141, 157, 232, 1),
                    errorText: error,
                    focusColor: Colors.white,
                    labelStyle: const TextStyle(
                      letterSpacing: 1,
                      color: Color(0xff999999),
                      backgroundColor: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(141, 157, 232, 1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(141, 157, 232, 1),
                        width: 2,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                onChanged: (String? out) {
                  if (out != null) {
                    selectedIndex.value = items.indexWhere(
                      (element) => element == out,
                    );
                  }
                },
                selectedItem: sv == null ? null : items[sv],
              );
            },
          );
        }); /* 
    return ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, si, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              textTheme: ThemeData.light().textTheme.copyWith(
                    labelMedium: const TextStyle(
                      color: Color(0xff999999),
                    ),
                    titleMedium: const TextStyle(
                      color: Color(0xff999999),
                    ),
                    displayMedium: const TextStyle(
                      color: Color(0xff999999),
                    ),
                    bodyMedium: const TextStyle(
                      color: Color(0xff999999),
                    ),
                    headlineMedium: const TextStyle(
                      color: Color(0xff999999),
                    ),
                  ),
            ),
            child: CustomDropdownButton2(
              buttonWidth: 200,
              dropdownWidth: 300,
              hint: hint,
              dropdownItems: items,
              buttonDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: const Color(0xff777777),
                ),
              ),
              value: si == null
                  ? (items.isEmpty)
                      ? unSelectedHint
                      : items[0]
                  : items[si],
              onChanged: (value) {
                selectedIndex.value = items.indexOf(value!);
              },
            ),
          );
        }); */
  }
}
