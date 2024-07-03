import 'package:flutter/material.dart';

/// button custom yang digunakan di projoct ini
class CustomButton extends StatefulWidget {
  const CustomButton(
      {required this.text, required this.action, this.width = 150, super.key});
  final Function()? action;
  final String text;
  final double width;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  ValueNotifier<bool> isHover = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isHover,
        builder: (context, ih, child) {
          return Material(
            elevation: (ih) ? 0 : 2,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            child: GestureDetector(
              onTap: widget.action,
              onTapDown: (value) {
                isHover.value = true;
              },
              onTapCancel: () {
                isHover.value = false;
              },
              onTapUp: (v) {
                isHover.value = false;
              },
              child: Container(
                height: 30,
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: (ih)
                      ? const Color.fromARGB(255, 100, 112, 165)
                      : const Color.fromRGBO(141, 157, 232, 1),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
