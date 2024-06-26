import 'package:flutter/material.dart';
import 'package:the_company/features/shop/screens/product_reviews/widget/progress_indicator_and_rating.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "4.8",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              RatingProgressIndicator(
                text: '5',
                value: 1.0,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.7,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.5,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.3,
              ),
              RatingProgressIndicator(
                text: '5',
                value: 0.1,
              )
            ],
          ),
        )
      ],
    );
  }
}
