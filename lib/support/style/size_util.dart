import 'package:flutter_sizer/flutter_sizer.dart';

double sizeWith(int n) {
  return Adaptive.w(100) > 475
      ? 475 / 100 * n
      : Adaptive.w(n);
}