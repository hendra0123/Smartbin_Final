import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smartbin/pages/welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/ob1.svg',
      'title': 'Sort Your Waste Easily',
      'desc':
          'Identify and sort recyclable, non-recyclable, and hazardous waste with our smart system.'
    },
    {
      'image': 'assets/images/ob2.svg',
      'title': 'Earn Points for Good Habits',
      'desc':
          'Get rewarded every time you dispose of trash correctly — redeem points for real benefits.'
    },
    {
      'image': 'assets/images/ob3.svg',
      'title': 'Scan and Drop',
      'desc':
          'Use your phone to scan your unique code before throwing — track your impact instantly.'
    },
    {
      'image': 'assets/images/ob4.svg',
      'title': 'Join the Movement',
      'desc':
          'Help build a cleaner campus and future — one piece of trash at a time.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = index == onboardingData.length - 1;
                });
              },
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    SvgPicture.asset(onboardingData[index]['image']!),
                    SizedBox(height: 32),
                    Text(
                      onboardingData[index]['title']!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      onboardingData[index]['desc']!,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            onLastPage ? Colors.green : Color(0xFF104C3F),
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: () {
                        if (onLastPage) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (WelcomePage())));
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        onLastPage ? 'Done' : 'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 24,
              child: SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: WormEffect(
                  activeDotColor: Color(0xFF104C3F),
                  dotColor: Colors.grey.shade300,
                  dotHeight: 6,
                  dotWidth: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  _controller.jumpToPage(onboardingData.length - 1);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
