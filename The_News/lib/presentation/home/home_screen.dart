import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_news/common/widgets/heading.dart';
import 'package:the_news/presentation/home/widgets/category_icon.dart';
import 'package:the_news/presentation/home/widgets/image_indicator.dart';
import 'package:the_news/presentation/home/widgets/image_with_text.dart';
import 'package:the_news/presentation/home/widgets/news_tile.dart';
import 'package:the_news/providers/home_provider.dart';
import 'package:the_news/utils/constants/color.dart';
import 'package:the_news/utils/device/device_utility.dart';
import 'package:the_news/utils/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    provider.initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(text: "The"),
          TextSpan(
              text: " News",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: CColors.primary))
        ])),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: value.categories.length,
                    itemBuilder: (_, index) {
                      return CategoryIcon(
                          image: value.categories[index].image!,
                          categoryName: value.categories[index].categoryName!);
                    }),
              ),
              Heading(
                title: 'Breaking News!',
              ),
              CarouselSlider.builder(
                  itemCount: value.sliders.length,
                  itemBuilder: (_, index, realIndex) {
                    String? image = value.sliders[index].image;
                    String? name = value.sliders[index].name;
                    return ImageWithText(
                      urlImage: image!,
                      index: index,
                      name: name!,
                    );
                  },
                  options: CarouselOptions(
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        value.updateIndex(index);
                      },
                      height: 250,
                      enlargeCenterPage: true,
                      autoPlay: true)),
              const SizedBox(
                height: 10,
              ),
              const Center(child: ImageIndicator()),
              Heading(title: 'Trending News!'),
              const SizedBox(
                height: 10,
              ),
              NewsTile(
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.landingScreen);
                },
                title: 'Rui Consta utsprints breakaway to win stage 15',
                subTitle: "sthen a final kick to heat kendnard kamna",
              )
            ],
          ),
        );
      }),
    );
  }
}
