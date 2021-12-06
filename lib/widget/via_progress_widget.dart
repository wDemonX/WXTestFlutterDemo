import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViaProgressWidget extends StatelessWidget {
  const ViaProgressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xff11b979)
      ),
    ));
  }
}