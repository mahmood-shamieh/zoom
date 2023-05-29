// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_application/Constant.dart';

import 'package:web_application/Controller/SubCatContentcontroller.dart';

import 'package:web_application/Models/ResponseModel.dart';
import 'package:web_application/Pages/Pages.dart';

import 'package:web_application/widgets/MyText.dart';

class AfterSubCatPagesController extends GetxController {
  var isLoading = true.obs;
  var textFields = [].obs;
  var dropDowns = [].obs;
  var multiTextField = [].obs;
  var imageLoaders = [].obs;
  var auto = false.obs;
  ResponseModel responseModel = ResponseModel();
  SubCatContentContoller subCatContentContoller = SubCatContentContoller();

  void getConatinent(Map map) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        isLoading(true);
        await subCatContentContoller.getSubCatContent(map).then((value) {
          // print(value);
          textFields.value = value['textFields'];
          dropDowns.value = value['dropDowns'];
          multiTextField.value = value['multiTextField'];
          imageLoaders.value = value['imageLoaders'];
          // auto.value = value[];
        });
      } finally {
        isLoading(false);
        update();
      }
    });
  }

  void addOrder(Map map, int sign, bool reSentOrder, bool? auto) async {
    await subCatContentContoller
        .addOrder(map)
        .then((value) => responseModel = value);

    if ((reSentOrder ?? false) && responseModel.status!) {
      await subCatContentContoller.setOrderSent(map['order_id']);
    }
    MyConst.profilePageController.getUserInformations();
    if (!reSentOrder ?? true) {
      Get.back();
      Get.back();
    }

    if (responseModel.status!) {
      if (sign == 1) {
        Get.back();
        Get.back();
      } else {
        MyConst.drawerController.updateDrawer(0);
        MyConst.styleWidgetController.navigate(Pages.homePage, Get.context);
      }
    }
    print(responseModel);
    // print(map['subcat_id'] == "135");
    if (/* ["135", "139", "140"].contains(map['subcat_id']) */ auto ?? false) {
      // print(["200", "204"].contains(responseModel.data['code']));
      Get.defaultDialog(
          title: responseModel.status! ? "نجاح" : "فشل",
          content: Column(
            children: [
              ["200", "204"].contains(responseModel.data['code'].toString())
                  ? Column(
                      children: [
                        MyText(
                          bold: true,
                          size: 16,
                          content:
                              responseModel.data['info'].toString().length == 0
                                  ? "لا يوجد معلومات"
                                  : responseModel.data['info'].toString(),
                        ),
                        responseModel.data['price'] == null
                            ? SizedBox()
                            : MyText(
                                bold: true,
                                size: 16,
                                content: "المبالغ المستحقة : " +
                                    responseModel.data['price'].toString(),
                              ),
                        responseModel.data['price_cut'] == null
                            ? SizedBox()
                            : MyText(
                                bold: true,
                                size: 16,
                                content: "المبالغ المقطوعة : " +
                                    responseModel.data['price_cut'].toString(),
                              ),
                      ],
                    )
                  : MyText(
                      bold: false,
                      size: 16,
                      content: responseModel.data['info'],
                    ),
            ],
          ),
          actions: <Widget>[
            responseModel.data['price_cut'] == null
                ? Container()
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blueColor)),
                    onPressed: () async {
                      Get.to(() => Container(
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ));
                      map['type'] = 1;
                      map['bill'] = responseModel.data['price_cut'];
                      print(map);
                      await subCatContentContoller
                          .addOrder(map)
                          .then((value) => responseModel = value);
                      Get.back();
                      Get.back();
                      Get.defaultDialog(
                          title: responseModel.status! ? "نجاح" : "فشل",
                          content: Column(
                            children: [
                              MyText(
                                bold: false,
                                size: 16,
                                content: responseModel.msg!,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            InkWell(
                                onTap: () {
                                  if (responseModel.status!) {
                                    if (sign == 1) {
                                      Get.back();
                                      Get.back();
                                    } else {
                                      MyConst.drawerController.updateDrawer(0);
                                      MyConst.styleWidgetController.navigate(
                                          Pages.homePage, Get.context);
                                    }
                                  }
                                  Get.back();
                                },
                                child: Center(
                                    child: Icon(
                                  Icons.close_rounded,
                                  size: 40,
                                ))),
                          ]);
                    },
                    child: Center(
                        child: MyText(
                      bold: true,
                      color: Colors.white,
                      content: "تسديد",
                      size: 16,
                    ))),
            InkWell(
                onTap: () {
                  if (responseModel.status!) {
                    if (sign == 1) {
                      Get.back();
                      Get.back();
                      // MyConst.styleWidgetController
                      // .navigate(Pages.orderHistory, Get.context);
                    } else {
                      MyConst.drawerController.updateDrawer(0);
                      MyConst.styleWidgetController
                          .navigate(Pages.paymentHistory, Get.context);
                    }
                  }
                  Get.back();
                },
                child: Center(
                    child: Icon(
                  Icons.close_rounded,
                  size: 40,
                )))
          ]);
    } else {
      Get.defaultDialog(
          title: responseModel.status! ? "نجاح" : "فشل",
          content: Column(
            children: [
              MyText(
                bold: false,
                size: 16,
                content: responseModel.msg!,
              ),
            ],
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  if (responseModel.status!) {
                    if (sign == 1) {
                      Get.back();
                      Get.back();
                    } else {
                      MyConst.drawerController.updateDrawer(0);
                      MyConst.styleWidgetController
                          .navigate(Pages.homePage, Get.context);
                    }
                  }
                  Get.back();
                },
                child: Center(
                    child: Icon(
                  Icons.close_rounded,
                  size: 40,
                ))),
          ]);
    }
  }

  void setOrderSent(String orderId, int sign) async {
    await subCatContentContoller
        .setOrderSent(orderId)
        .then((value) => responseModel = value);
    MyConst.profilePageController.getUserInformations();
    Get.back();
    Get.back();
    if (responseModel.status!) {
      if (sign == 1) {
        Get.back();
        Get.back();
      } else {
        MyConst.drawerController.updateDrawer(0);
        MyConst.styleWidgetController.navigate(Pages.homePage, Get.context);
      }
    }
  }
}
