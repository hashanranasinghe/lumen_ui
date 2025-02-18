import 'package:flutter/material.dart';
import 'package:lumen_ui/src/styles/color/color.dart';
import 'package:lumen_ui/src/styles/style/styles.dart';

class DummyTemplate extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double pleft;
  final double pright;
  final double ptop;
  final double pbottom;
  final Function onpress;
  final double fontsize;
  const DummyTemplate({
    this.color = AppColors.blue,
    this.textcolor = AppColors.darkBlue,
    this.text = "Button",
    this.pleft = 15,
    this.pright = 15,
    this.ptop = 10,
    this.pbottom = 10,
    Key? key,
    required this.onpress,
    this.fontsize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text,
          style: AppStyle.textButtonReg.copyWith(
            color: color,
            fontSize: fontsize,
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1.0,
            backgroundColor: color,
            padding: EdgeInsets.only(
                left: pleft, right: pright, top: ptop, bottom: pbottom)),
      ),
    );
  }
}
