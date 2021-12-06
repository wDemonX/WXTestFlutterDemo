import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViaBackButton extends StatelessWidget {
  const ViaBackButton({Key? key, this.color, this.onPressed}) : super(key: key);

  final Color? color;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 16,
      ),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
