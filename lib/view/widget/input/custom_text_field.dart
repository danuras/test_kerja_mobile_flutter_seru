import 'package:flutter/material.dart';

/// widget yang dapat digunakan untuk menginputkan text
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.hintText,
    required this.errorText,
    required this.controller,
    this.fontSize,
    this.tooltip,
    this.prefixIcon,
    this.obscureText = false,
    this.isRequired = false,
    this.keyBoardType,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.readOnly = false,
  });
  final ValueNotifier errorText;
  final TextEditingController controller;
  final int maxLines;
  final int? minLines;
  final String? labelText;
  final String? tooltip;
  final String? hintText;
  final int? maxLength;
  final bool obscureText;
  final bool isRequired;
  final double? fontSize;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;
  final Function(String? value)? onChanged;
  final Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: errorText,
      builder: (context, error, child) {
        return TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyBoardType,
          onChanged: onChanged,
          maxLength: maxLength,
          textAlignVertical: TextAlignVertical.top,
          style: TextStyle(
            color: const Color(0xff999999),
            fontSize: fontSize,
          ),
          obscureText: obscureText,
          cursorColor: const Color.fromRGBO(141, 157, 232, 1),
          decoration: InputDecoration(
            label: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: labelText,
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
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: (prefixIcon != null)
                ? Icon(
                    prefixIcon!,
                    color: const Color.fromRGBO(141, 157, 232, 1),
                  )
                : null,
            suffixIcon: (tooltip != null)
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      right: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      widthFactor: 1.0,
                      heightFactor: maxLines * 1.0,
                      child: Tooltip(
                        message: tooltip,
                        textStyle: const TextStyle(color: Colors.black),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(141, 157, 232, 1),
                            width: 2,
                          ),
                        ),
                        triggerMode: TooltipTriggerMode.tap,
                        child: const Icon(
                          Icons.help_outline,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                  )
                : suffixIcon,
            errorText: error,
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
            alignLabelWithHint: true,
          ),
        );
      },
    );
  }
}
