import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViaLoadMoreWidget extends StatelessWidget {
  const ViaLoadMoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: const Center(
          child: SizedBox(
        width: 20,
        height: 20,
        child:
            CircularProgressIndicator(strokeWidth: 2, color: Color(0xff11b979)),
      )),
    );
  }
}
