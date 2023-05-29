// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

class ADSLWidget extends StatefulWidget {
  String? name;
  Function()? function;
  ImageProvider? provider;

  ADSLWidget({
    Key? key,
    this.name,
    this.function,
  }) : super(key: key);

  @override
  _ADSLWidgetState createState() => _ADSLWidgetState();
}

class MyCustomPainter extends CustomPainter {
  Color backgroundColor;
  MyCustomPainter({
    required this.backgroundColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 20;

    Path path = Path();
    path.moveTo(0 + size.width / 2, 0);
    path.lineTo(0, size.height / 2);
    path.lineTo(0 + size.width / 2, size.height);
    path.lineTo(size.width, size.height / 2);
    canvas.drawShadow(path, greenColor, 60, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _ADSLWidgetState extends State<ADSLWidget> {
  String getImageLink() {
    switch (widget.name) {
      case "يارا":
        return "images/يارا.png";
      case "MTN ADSL":
        return "images/ام اي ان.png";
      case "HiFi":
        return "images/هايفاي.png";
      case "هايبر نت":
        return "images/هايبر نت.png";
      case "ناس":
        return "images/ناس.png";
      case "ليما":
        return "images/ليما.png";
      case "لاين نت":
        return "images/لاين نت.png";
      case "ليزر نت":
        return "images/لايبر نت.png";
      case "VIEW":
        return "images/فيو.png";
      case "سوا":
        return "images/سوا.png";
      case "سما نت":
        return "images/سما نت.png";
      case "زاد":
        return "images/زاد.png";
      case "رن نت":
        return "images/رن نت.png";
      case "دنيا":
        return "images/دنيا.png";
      case "تكامل":
        return "images/تكامل.png";
      case "بطاقات":
        return "images/بطاقات.png";
      case "برونت":
        return "images/برونت.png";
      case "INET":
        return "images/آي نت.png";
      case "أمواج":
        return "images/أمواج.png";
      case "أمنية":
        return "images/أمنية.png";
      case "MTS":
        return "images/ام كي اس.png";
      case "إلكم":
        return "images/إلكم.png";
      case "الجمعية العلمية":
        return "images/الجمعية العلمية.png";
      case "اَية":
        return "images/آية.png";
      default:
        return 'images/error.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.provider = AssetImage(getImageLink());
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: widget.function,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(
                  (GetPlatform.isAndroid
                          ? (MediaQuery.of(context).size.width / 8) + 29
                          : 80) *
                      2,
                  (GetPlatform.isAndroid
                          ? (MediaQuery.of(context).size.width / 8) + 29
                          : 80) *
                      2),
              painter: MyCustomPainter(backgroundColor: greenColor),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ((GetPlatform.isAndroid
                              ? (MediaQuery.of(context).size.width / 8) + 29
                              : 80) *
                          2) /
                      4,
                  right: ((GetPlatform.isAndroid
                              ? (MediaQuery.of(context).size.width / 8) + 29
                              : 80) *
                          2) /
                      4),
              width: ((GetPlatform.isAndroid
                          ? (MediaQuery.of(context).size.width / 8) + 29
                          : 80) *
                      2) /
                  2,
              height: ((GetPlatform.isAndroid
                          ? (MediaQuery.of(context).size.width / 8) + 29
                          : 80) *
                      2) /
                  2,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: widget.provider!,
                  onError: (exception, stackTrace) => setState(() {
                    widget.provider = AssetImage("images/error.gif");
                  }),
                ),
                borderRadius: BorderRadiusDirectional.circular(5),
                // boxShadow: [
                //   BoxShadow(
                //       color: blueColor, spreadRadius: 5, blurRadius: 10)
                // ],
              ),
              // child:
              // Image(
              //   errorBuilder: (context, error, stackTrace) => Image(
              //     image: AssetImage("images/error.gif"),
              //     fit: BoxFit.contain,
              //   ),
              //   fit: BoxFit.cover,
              //   image: AssetImage(getImageLink()),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
