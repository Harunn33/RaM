import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum Images {
  alien("alien"),
  alive("alive"),
  dead("dead"),
  man("man"),
  woman("woman"),
  unknown("unknown"),
  genderless("genderless"),
  robot("robot"),
  human("human");

  final String value;
  const Images(this.value);

  SvgPicture get svg => SvgPicture.asset("assets/images/$value.svg");
  SvgPicture get svgWithScale => SvgPicture.asset(
        "assets/images/$value.svg",
        width: 5.h,
        height: 5.h,
      );
}
