// ignore_for_file: non_constant_identifier_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/modules/home/home_controller.dart';
import 'package:rick_and_morty/shared/constants/constants.dart';
import 'package:sizer/sizer.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "RaM",
            style: AppTextStyle.cardText,
          ),
        ),
        body: Obx(
          () {
            return controller.loading.value
                ? Obx(
                    () => Center(
                      child: Text(
                        "Veriler Yükleniyor... ${controller.percent.value}",
                        style: AppTextStyle.cardText,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Swiper(
                          layout: SwiperLayout.CUSTOM,
                          onIndexChanged: (value) {
                            controller.counter.value = value + 1;
                          },
                          customLayoutOption:
                              CustomLayoutOption(startIndex: -1, stateCount: 3)
                                ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                                ..addTranslate([
                                  Offset(-90.w, -6.h),
                                  const Offset(0.0, 0.0),
                                  Offset(90.w, -6.h)
                                ]),
                          itemWidth: 69.w,
                          itemHeight: 70.h,
                          itemBuilder: (context, index) {
                            return FlipCard(
                              fill: Fill.fillBack,
                              direction: FlipDirection.HORIZONTAL,
                              back: _CustomCardBack(index),
                              front: _CustomCardFront(index),
                            );
                          },
                          itemCount: controller.characters.length,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.counter.value.toString()}/${controller.characters.length}",
                          style: AppTextStyle.cardText,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Container _CustomCardBack(int index) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, .1.h),
            color: AppColors.black,
            blurRadius: 10.sp,
          )
        ],
        color:
            index.isEven ? AppColors.chapelBlue : AppColors.agedPlasticCasing,
        borderRadius: BorderRadius.circular(
          24.sp,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
            ),
            child: Text(
              "Other Informations",
              style: AppTextStyle.cardTextBack,
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: .3.h,
              ),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 2.h,
                ),
                itemCount: controller
                    .charactersByIds[controller.counter.value - 1]["episode"]
                    .length,
                itemBuilder: (context, indx) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: .4.w,
                        color: AppColors.black,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.sp,
                      ),
                    ),
                    margin: EdgeInsets.only(
                      bottom: 2.h,
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Episode: ${controller.charactersByIds[controller.counter.value - 1]["episode"][indx]["episode"]}",
                              style: AppTextStyle.cardTextBack,
                            ),
                            AppSpacing.s1.appSpaceHeight,
                            Text(
                              "Episode Name: ${controller.charactersByIds[controller.counter.value - 1]["episode"][indx]["name"]}",
                              style: AppTextStyle.cardTextBack,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(
                          bottom: 1.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location Name: ${controller.charactersByIds[controller.counter.value - 1]["location"]["name"]}",
                              style: AppTextStyle.cardTextBack,
                            ),
                            AppSpacing.s1.appSpaceHeight,
                            Text(
                              "Location Type: ${controller.charactersByIds[controller.counter.value - 1]["location"]["type"]}",
                              style: AppTextStyle.cardTextBack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _CustomCardFront(int index) {
    return Container(
      decoration: BoxDecoration(
        //MAYBE
        // image: DecorationImage(
        //     image: NetworkImage(controller.characters[index]["image"]),
        //     fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, .1.h),
            color: AppColors.black,
            blurRadius: 10.sp,
          )
        ],
        color:
            index.isEven ? AppColors.chapelBlue : AppColors.agedPlasticCasing,
        borderRadius: BorderRadius.circular(
          24.sp,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24.sp),
              ),
              child: SizedBox(
                width: 100.w,
                child: Image.network(
                  controller.characters[index]["image"],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name: ${controller.characters[index]["name"]}",
                    style: AppTextStyle.cardText,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Species: ${controller.characters[index]["species"]}",
                          style: AppTextStyle.cardText,
                        ),
                      ),
                      Expanded(
                        child: controller.characters[index]["species"] ==
                                "Human"
                            ? Images.human.svgWithScale
                            : controller.characters[index]["species"] == "Robot"
                                ? Images.robot.svgWithScale
                                : controller.characters[index]["species"] ==
                                        "Alien"
                                    ? Images.alien.svgWithScale
                                    : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Status: ${controller.characters[index]["status"]}",
                          style: AppTextStyle.cardText,
                        ),
                      ),
                      Expanded(
                        child: controller.characters[index]["status"] == "Dead"
                            ? Images.dead.svgWithScale
                            : controller.characters[index]["status"] == "Alive"
                                ? Images.alive.svgWithScale
                                : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Gender: ${controller.characters[index]["gender"]}",
                          style: AppTextStyle.cardText,
                        ),
                      ),
                      Expanded(
                        child: controller.characters[index]["gender"] ==
                                "Genderless"
                            ? Images.genderless.svgWithScale
                            : controller.characters[index]["gender"] == "Male"
                                ? Images.man.svgWithScale
                                : controller.characters[index]["gender"] ==
                                        "Female"
                                    ? Images.woman.svgWithScale
                                    : const SizedBox.shrink(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
