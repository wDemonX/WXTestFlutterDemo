import 'package:flutter/material.dart';


/// 虚线Widget
///  Widget _dashLine() {
///     return const SizedBox(
///       height: 20,
///       child: ViaDashLine(
///         color: Color(0xFFAEB0C0),
///         dashHeight: 4,
///         dashWidth: 1,
///       ),
///     );
///   }
class ViaDashLine extends StatelessWidget {

  final double dashHeight;
  final double dashWidth;
  final Color color;
  final Axis direction;

  const ViaDashLine({Key? key, this.dashHeight = 1, this.color = Colors.black, this.dashWidth = 1, this.direction = Axis.vertical}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final boxHeight = constraints.constrainHeight();

        final constrainLength = direction == Axis.vertical ? boxHeight : boxWidth;
        final segmentLength = direction == Axis.vertical ? dashHeight : dashWidth;

        final dashCount = (constrainLength / (2 * segmentLength)).ceil();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
        );
      },
    );
  }
}