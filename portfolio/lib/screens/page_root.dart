import 'dart:html';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/controller.dart';
import 'package:portfolio/responsive/aboutScreen_mobileLayout.dart';
import 'package:portfolio/responsive/contactScreen_mobileLayout.dart';
import 'package:portfolio/responsive/experienceScreen_mobileLayout.dart';
import 'package:portfolio/responsive/homeScreen_mobileLayout.dart';
import 'package:portfolio/responsive/responsive_layout.dart';
import 'package:portfolio/screens/about_page.dart';
import 'package:portfolio/screens/contact_page.dart';
import 'package:portfolio/components/theming.dart';
import 'package:portfolio/screens/experience_page.dart';
import 'package:portfolio/screens/home_page.dart';
import 'package:portfolio/screens/resume_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responsive/resumeScreen_mobileLayout.dart';

class PageRoot extends StatefulWidget {
  const PageRoot({super.key});

  @override
  State<PageRoot> createState() => _PageRootState();
}

class _PageRootState extends State<PageRoot>
    with SingleTickerProviderStateMixin {
  // TabController? tabController;
  PageController? pageController;
  int _currentIndex = 0;
  static String resumeLink ='';
  static String resumeImageLink ='';


  final List<Widget> widgets = [
    const ResponsiveLayout(HomeScreenMobileLayout(), HomePage()),
    const ResponsiveLayout(AboutScreenMobileLayout(), AboutPage()),
    const ResponsiveLayout(ExperienceScreenMobileLayout(), ExperiencePage()),
    const ResponsiveLayout(ContactScreenMobileLayout(), ContactPage()),
    ResponsiveLayout(ResumeMobilePage(
      resumeImageLink: resumeImageLink,
      callback: () {
        launchLink(
          resumeLink
            );
      },
    ), ResumePage(
      resumeImageLink: resumeImageLink,
      callback: () {
        launchLink(
            resumeLink);
      },
    ))
  ];

  @override
  initState() {
    super.initState();
    // tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    pageController = PageController(initialPage: _currentIndex);
    controller.updateResume();
    resumeLink = controller.resumeLink.value;
    resumeImageLink = controller.resumeImage.value;
  }

  static Future<void> launchLink(String link) async {
    final Uri _uri = Uri.parse(link);
    if (await canLaunchUrl(_uri)) {
      await launchUrl(_uri);
    } else {
      throw Exception("Unable to Launch Url $_uri");
    }
  }

  var controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {

    final Size mediaQueryData = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: _currentIndex==4?const Color(0xff002746):Colors.transparent,
          actions: [
            mediaQueryData.width < mobileWidth
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        pageController?.animateToPage(0,
                            duration: const Duration(seconds: 2),
                            curve: Curves.ease);
                      });
                    },
                    child: Text(
                      "Home",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (MediaQuery.of(context).size.width / 41)
                              .floorToDouble()),
                    ))
                : TextButton(
                    onPressed: () {
                      setState(() {
                        pageController?.animateToPage(0,
                            duration: const Duration(seconds: 2),
                            curve: Curves.ease);
                      });
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    )),
            mediaQueryData.width < mobileWidth
                ? Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(1,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: Text(
                          "About",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (MediaQuery.of(context).size.width / 41)
                                  .floorToDouble()),
                        )),
                  )
                : Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(1,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: const Text(
                          "About",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
            mediaQueryData.width < mobileWidth
                ? Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(2,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: Text(
                          "Experience",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (MediaQuery.of(context).size.width / 41)
                                  .floorToDouble()),
                        )),
                  )
                : Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(2,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: const Text(
                          "Experience",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
            mediaQueryData.width < mobileWidth
                ? Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(3,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: Text(
                          "Contact",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (MediaQuery.of(context).size.width / 41)
                                  .floorToDouble()),
                        )),
                  )
                : Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width / 42)
                            .floorToDouble()),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(3,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                        },
                        child: const Text(
                          "Contact",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
            mediaQueryData.width < mobileWidth
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 41)
                            .floorToDouble()),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ButtonColor.backgroundColor(_currentIndex),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          setState(() {
                            pageController?.animateToPage(4,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease);
                          });
                          // launchLink(
                          //     "https://drive.google.com/file/d/1hBPN-pAL1Y2OXGrYvaO4FNjAPTRYghEt/view?usp=sharing")
                        },
                        child: Text(
                          "Resume",
                          style: TextStyle(
                              color:  _currentIndex==4?Colors.black:Colors.white,
                              fontSize: (MediaQuery.of(context).size.width / 41)
                                  .floorToDouble()),
                        )),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 41)
                            .floorToDouble()),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ButtonColor.backgroundColor(_currentIndex),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () => {
                              setState(() {
                                pageController?.animateToPage(4,
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.ease);
                              })
                              // launchLink(
                              //     "https://drive.google.com/file/d/1hBPN-pAL1Y2OXGrYvaO4FNjAPTRYghEt/view?usp=sharing")
                            },
                        child:  Text(
                          "Resume",
                          style: TextStyle(color: _currentIndex==4?Colors.black:Colors.white),
                        )),
                  ),
          ],
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: BackgroundImage.backgroundImageSetter(_currentIndex),
                  fit: BoxFit.cover)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width / 58)
                        .floorToDouble(),
                    bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await launchLink(
                              "https://github.com/AADILKHAN99A/App_Development");
                        },
                        icon: Image.asset(
                          'assets/github-icon.png',
                          width: 35,
                        )),
                    IconButton(
                        onPressed: () async {
                          await launchLink(
                              "https://www.linkedin.com/in/aadilkhan99a/");
                        },
                        icon: Image.asset(
                          'assets/linkedinIcon.png',
                          width: 35,
                        )),
                    IconButton(
                        onPressed: () async {
                          await launchLink(
                              "https://join.skype.com/invite/q1PaXqXQ6SVr");
                        },
                        icon: Image.asset(
                          'assets/skypeIcon.png',
                          width: 35,
                        )),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width / 29)
                          .floorToDouble()),
                  child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: widgets),
                ),
              ),
            ],
          ),
        ));
  }
}
