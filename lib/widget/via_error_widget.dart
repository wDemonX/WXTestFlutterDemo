import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Error Widget
class ViaErrorWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const ViaErrorWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/png/ic_network_error.png",
            width: 180.w,
            height: 180.w,
          ),
          const Text("网络不佳",
              style: TextStyle(
                color: Color(0xFF838492),
                fontSize: 14,
              )),
          const SizedBox(height: 15),
          OutlinedButton(
            child: const Text("重新加载",
                style: TextStyle(
                  color: Color(0xFF61616C),
                  fontSize: 14,
                )),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xFFAEB0C0), width: 1)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(13, 0, 13, 0)),
            ),
            onPressed: onPressed,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
