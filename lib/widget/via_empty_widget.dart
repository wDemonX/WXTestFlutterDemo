import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Empty Widget
class ViaEmptyWidget extends StatelessWidget {

  const ViaEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/png/ic_empty.png",
            width: 180.w,
            height: 180.w,
          ),
          const Text("暂无内容",
              style: TextStyle(
                color: Color(0xFF838492),
                fontSize: 14,
              )),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
