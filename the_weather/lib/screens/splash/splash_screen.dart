import 'package:flutter/material.dart';
import 'package:the_weather/common/widgets/dual_toned_blur_widget.dart';
import 'package:the_weather/utils/constants/enums.dart';
import 'package:the_weather/utils/constants/image_strings.dart';
import 'package:the_weather/utils/constants/sizes.dart';
import 'package:the_weather/utils/constants/texts.dart';
import 'package:the_weather/utils/helpers/helper_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.type});

  final SplashType type;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
  }

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    _controller.repeat();
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SizedBox(
        height: HelperFunctions.screenHeight(context),
        child: Stack(
          children: [
            const DualTonedBlur(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                    child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: const Image(image: AssetImage(CImages.clear)),
                )),
                const SizedBox(
                  height: CSizes.spaceBtwSections,
                ),
                if (widget.type == SplashType.appLoading)
                  Text(
                    CTexts.appName,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .apply(fontWeightDelta: 5),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }
}
