import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

double sizeWidth(int n) {
  return Adaptive.w(100) > 475 ? 475 / 100 * n : Adaptive.w(n);
}

EdgeInsetsGeometry basePadding({double? vertical}) {
  return EdgeInsets.symmetric(
      vertical: vertical == null ? 0 : vertical,
      horizontal: Adaptive.w(100) > 475 ? 475 / 100 * 5 : Adaptive.w(5));
}
