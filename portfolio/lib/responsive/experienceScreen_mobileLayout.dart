import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../project_data.dart';

class ExperienceScreenMobileLayout extends StatefulWidget {
  const ExperienceScreenMobileLayout({super.key});

  @override
  State<ExperienceScreenMobileLayout> createState() =>
      _ExperienceScreenMobileLayoutState();
}

class _ExperienceScreenMobileLayoutState
    extends State<ExperienceScreenMobileLayout> {
  ProjectData projectDataObj = ProjectData();
  late Map<dynamic, dynamic> projectData;

  @override
  initState() {
    super.initState();
    projectData = projectDataObj.projectData;
  }

  Future<void> launchLink(String link) async {
    final Uri _url = Uri.parse(link);

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ListView.separated(
        itemCount: projectData.length,
        itemBuilder: (BuildContext context, int index) {
          List list = projectData[index]["responsiveImages"] as List;
          return Column(
            children: [
              CarouselSlider(
                  items: list.map((e) {
                    return Image.asset(
                        "assets/projects/${projectData[index]["name"].toLowerCase()}/$e.png");
                  }).toList(),
                  options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      projectData[index]["name"],
                      style: const TextStyle(
                          fontSize: 29, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                      elevation: 20,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff112742),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Center(
                              child: Text(
                                projectData[index]["description"],
                                style: const TextStyle(),
                                softWrap: true,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      projectData[index]["technology"],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                        onPressed: () async {
                          await launchLink(projectData[index]["github"]);
                        },
                        icon: const ImageIcon(
                            size: 45,
                            color: Colors.white,
                            AssetImage("assets/github-icon.png"))),
                  )
                ],
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 50,
          );
        },
      ),
    );
  }
}
