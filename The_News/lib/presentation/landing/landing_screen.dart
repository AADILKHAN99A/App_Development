import 'package:flutter/material.dart';
import 'package:the_news/utils/constants/color.dart';
import 'package:the_news/utils/device/device_utility.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/business.jpg",
                  width: DeviceUtils.getScreenWidth(context),
                  height: DeviceUtils.getScreenHeight(context) / 1.7,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 20,
            ),
            Text("News from around the\n          world for you",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(fontWeightDelta: 5)),
            Text(
              "Best time to read, take your time to read\n                 a little more of this world",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: CColors.darkGrey),
            )
          ],
        ),
      ),
    );
  }
}
