import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.image,
    required this.categoryName,
  });

  final String image;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          width: 120,
          height: 60,
          image: AssetImage(image),
        ),
        Text(categoryName)
      ],
    );
  }
}