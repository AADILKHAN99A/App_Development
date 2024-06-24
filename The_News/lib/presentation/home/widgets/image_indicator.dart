import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_news/providers/home_provider.dart';

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, value) {
      return AnimatedSmoothIndicator(
          activeIndex: provider.activeIndex,
          count: provider.sliders.length,
          effect: SlideEffect(
              dotWidth: 15, activeDotColor: Colors.purple, dotHeight: 15));
    });
  }
}
