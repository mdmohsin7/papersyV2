import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../sizeconfig.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: _height * 17,
              width: _width * 22,
              child: SvgPicture.asset("assets/error.svg"),
            ),
            const Text(
              "DEAD END",
              textAlign: TextAlign.center,
            ),
            const Text(
              "The page you are looking for doesn't seem to exist...",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
