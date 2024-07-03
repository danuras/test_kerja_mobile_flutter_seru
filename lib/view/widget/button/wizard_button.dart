import 'package:flutter/material.dart';
import 'package:test_kerja_screen_wizard/view/widget/button/custom_button.dart';

/// button navigasi untuk berpindah ke langkah sebelumnya dan sesudahnya pada halaman wizard
class WizardButton extends StatelessWidget {
  const WizardButton({
    super.key,
    required this.isFirst,
    required this.isLast,
    this.backAction,
    this.nextAction,
    this.save,
  });
  final bool isFirst, isLast;
  final Function()? backAction, nextAction;
  final Function()? save;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFirst)
          CustomButton(
            text: 'Sebelumnya',
            action: backAction,
          ),
        const Spacer(),
        if (!isLast)
          CustomButton(
            text: 'Selanjutnya',
            action: nextAction,
          ),
        if (isLast)
          CustomButton(
            text: 'Simpan',
            action: save!,
          ),
      ],
    );
  }
}
