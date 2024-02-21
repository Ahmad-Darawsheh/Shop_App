

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.body,
    required this.image,
    required this.title,
  });
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  List<BoardingModel> boarding = [
    BoardingModel(
        body: "body1", image: "assests/images/onboard.png", title: "title1"),
    BoardingModel(
        body: "body2", image: "assests/images/onboard.png", title: "title2"),
    BoardingModel(
        body: "body3", image: "assests/images/onboard.png", title: "title3")
  ];



  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {

    void submit() {
      CacheHelper.saveData(key: "onBoarding", value: true, ).then((value) => {
        if (value) {navigateToAndFinish(context, ShopLoginScreen())}
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(
                  body: boarding[index].body,
                  title: boarding[index].title,
                  image: boarding[index].image,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem({
    required String title,
    required String body,
    required String image,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            body,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // PageView.builder(
          //     itemBuilder: (context,index)
          // )
        ],
      );
}
