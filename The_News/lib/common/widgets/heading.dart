import 'package:flutter/material.dart';
import 'package:the_news/utils/constants/color.dart';

class Heading extends StatelessWidget {
  Heading({super.key, required this.title, this.onTap});

  final String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "View All",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: CColors.primary),
            ),
          )
        ],
      ),
    );
  }
}
