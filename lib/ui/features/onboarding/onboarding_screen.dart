import 'dart:developer' as console;

import 'package:crowfunding_project/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    super.initState();
  }

  void _handleButtonPressed() {
    if (pageIndex < Constants.onbardScreen.length - 1) {
      setState(() {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    } else {
      console.log('Get started pressed');
    }
  }

  void _skipToLoadPage() {
    setState(() {
      _pageController.animateToPage(
        Constants.onbardScreen.length - 1,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildPageIndicator(int itemCount) {
    const double dotRadius = 4.0;
    const double dotSpacing = 8.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isSelected = index == pageIndex;
        final width = isSelected ? dotRadius * 6 : dotRadius * 2;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: dotSpacing / 2),
          width: width,
          height: dotRadius * 2,
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey : Colors.grey[300],
            borderRadius: BorderRadius.circular(dotRadius),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            pageIndex == Constants.onbardScreen.length - 1
                ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/signin');
                    },
                    child: Text('Commencer'),
                  ),
                )
                : SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skipToLoadPage,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                        ),
                        child: Text('Passer'),
                      ),
                      _buildPageIndicator(Constants.onbardScreen.length),
                      ElevatedButton(
                        onPressed: _handleButtonPressed,
                        child: Text('Suivant'),
                      ),
                    ],
                  ),
                ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: Constants.onbardScreen.length,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = Constants.onbardScreen[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(item['image']!, fit: BoxFit.fill, height: 300),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      item['title']!,
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item['description']!,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
