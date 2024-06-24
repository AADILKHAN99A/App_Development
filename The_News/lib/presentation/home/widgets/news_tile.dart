import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/device/device_utility.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/general.jpg",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  SizedBox(
                    width: DeviceUtils.getScreenWidth(context) / 2,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 7),
                  SizedBox(
                    width: DeviceUtils.getScreenWidth(context) / 2,
                    child: Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: CColors.darkGrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
