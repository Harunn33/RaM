import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum AppSpacing {
  s0_5(.5),
  s1(1),
  s1_5(1.5),
  s2(2),
  s3(3),
  s4(4);

  final double value;
  const AppSpacing(this.value);

  SizedBox get appSpaceHeight => SizedBox(height: value.h);
  SizedBox get appSpaceWidth => SizedBox(width: value.w);
}
