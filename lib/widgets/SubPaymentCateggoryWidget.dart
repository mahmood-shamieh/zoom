// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_application/Constant.dart';
import 'package:web_application/Pages/PaymentPageProces.dart';
import 'package:web_application/Pages/SignInPage.dart';
import 'package:web_application/widgets/MyText.dart';

// ignore: must_be_immutable
class SubPaymentCateggoryWidget extends StatelessWidget {
  String? url, content;
  List<Widget>? items;
  bool? useAsset;
  String? subCatId;
  String? buttons;
  Function()? function;
  double? bounce;
  String? auto;

  SubPaymentCateggoryWidget(
      {Key? key,
      this.bounce,
      this.content,
      this.url,
      this.items,
      this.useAsset,
      this.buttons,
      this.function,
      this.subCatId,
      this.auto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
          child: Card(
            color: blueColor,
            shadowColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 140,
                    height: 80,
                    // color: Colors.black,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image(
                        errorBuilder: (context, error, stackTrace) => ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image(
                            image: AssetImage("images/error.gif"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        image: (useAsset!
                                ? AssetImage(url!)
                                : NetworkImage(url!) ??
                                    AssetImage('images/error.gif'))
                            as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width - 220,
                    child: MyText(
                      color: Colors.white,
                      content: content,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          onTap: function ??
              () {
                if (GetStorage().read("logedIn") != null) {
                  !GetStorage().read("logedIn")
                      ? Get.to(() => SignInPage())
                      : navigate(
                          PaymentPageprces(
                            bounce: bounce,
                            local: useAsset,
                            title: content,
                            buttons: buttons,
                            // items: items,
                            subCatId: subCatId,
                            auto: auto == "1" ? true : false,
                          ),
                          context);
                } else
                  Get.to(() => SignInPage());
              }),
    );
  }
}
