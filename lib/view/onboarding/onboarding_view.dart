
import 'package:flutter/material.dart';
import 'package:riding_app/utils/app_imports.dart';


class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List<SliderPage> _pageList = [
    SliderPage(
      svg: 'assets/images/on_one.png',
      body: 'LGURide – Ride Together, Save Together!'.tr(),
      title: 'Anywhere you are'.tr(),
      subBody: ' reasonable price. '.tr(),
    ),
    SliderPage(
      svg: 'assets/images/on_two.png',
      body: 'Sharing Rides, Building Connections! '.tr(),
      title: 'At anytime'.tr(),
      subBody: ' are verified by our system '.tr(),
    ),
    SliderPage(
      svg: 'assets/images/on_three.png',
      body: 'One Ride, Many Smiles!'.tr(),
      title: 'Book your car /Bike'.tr(),
      subBody: '',
    )
  ];
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: pageIndex != 0
            ? IconButton(
                onPressed: () {
                  if (pageIndex == 2) {
                    controller.jumpToPage(1);
                  } else if (pageIndex == 1) {
                    controller.jumpToPage(0);
                  }
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))
            : null,
        actions: [
          if (pageIndex == 0|| pageIndex==1)
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectModeView()),
                          (route) => false);
                },
                child: CustomText(
                  text: "Skip".tr(),
                  color: AppColors.primary,
                  fontSize: 16,
                )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 100,
              child: PageView.builder(
                controller: controller,
                physics: const ScrollPhysics(),
                onPageChanged: (val) {
                  pageIndex = val;
                  setState(() {});
                },
                itemCount: _pageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, i) {
                  return _pageList[i];
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  // height: 60,
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: double.parse(pageIndex.toString()),
                    decorator: DotsDecorator(
                      activeColor: AppColors.primary,
                      color: AppColors.contentDisabled,
                      size: const Size.square(9.0),
                      activeSize: const Size(27.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppButton(
                  onPressed: () {
                    if (pageIndex == 0) {
                      controller.jumpToPage(1);
                    } else if (pageIndex == 1) {
                      controller.jumpToPage(2);
                    } else if (pageIndex == 2) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectModeView()),
                          (route) => false);
                    }
                    setState(() {});
                  },
                  btnLabel: pageIndex <= 1 ? 'Next'.tr() : 'Get Started'.tr(),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
