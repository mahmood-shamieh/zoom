// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class PaymentMenuItem extends StatelessWidget {
  String? content;
  Function()? function;
  String? url;
  bool? useAsset;
  PaymentMenuItem(
      {Key? key, this.content, this.function, this.url, this.useAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 50;
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: function,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        // ignore: prefer_const_literals_to_create_immutables
                        // margin: EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: greenColor.withOpacity(0.8),
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                          // padding: const EdgeInsets.all(16),
                          width: radius * 2,
                          height: radius * 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: (useAsset ?? false
                                          ? AssetImage(url!)
                                          : (NetworkImage(url!) ??
                                              AssetImage('images/error.gif')))
                                      as ImageProvider)),
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  CustomPaint(
                    willChange: true,
                    size: Size(
                        Get.mediaQuery.size.width - radius - 15,
                        radius * 2 +
                            20), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: MyCustomPainter(
                        arrowSize: 70, backgroundColor: blueColor, radius: 1.0),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(top: 45),
                    // color: Colors.amber,
                    width: Get.mediaQuery.size.width - radius * 2 - 40,
                    child: Center(
                      child: MyText(
                        textOverflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        content: content,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class MyCustomPainter extends CustomPainter {
  double arrowSize;
  double radius;
  Color backgroundColor;
  MyCustomPainter(
      {required this.arrowSize,
      required this.backgroundColor,
      required this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path = Path();
    path.moveTo(0 + arrowSize, 0);
    path.lineTo(0, size.height / 2);
    path.lineTo(0 + arrowSize, size.height);
    path.lineTo(size.width, size.height);
    path.arcToPoint(Offset(size.width, 0), radius: Radius.circular(radius));
    // path.lineTo();
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
