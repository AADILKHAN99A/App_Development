import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/controller.dart';
import 'package:portfolio/project_data.dart';
import 'package:portfolio/utils/helper_functions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final controller = MyController.instance;

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
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: controller.projectData.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(top: 120),
          child: Transform.flip(
            flipX: controller.projectData[index].direction == "left"
                ? false
                : true,
            child: Stack(children: [
              const SizedBox(
                width: double.infinity,
                height: 500,
              ),
              Positioned(
                left: 200,
                child: Transform.flip(
                  flipX: controller.projectData[index].direction == "left"
                      ? false
                      : true,
                  child: Obx(() =>
                      controller.projectData[index].responsiveImages.last == ""
                          ? const Image(
                              image: AssetImage('assets/imageLoading.gif'))
                          : CachedNetworkImage(
                              imageUrl: controller
                                  .projectData[index].responsiveImages.last,
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                width: HelperFunctions.getScreenWidth() * 0.6,
                              ),
                              placeholder: (_, url) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(),
                                );
                              },
                            )),
                ),
              ),
              Transform.flip(
                flipX: controller.projectData[index].direction == "left"
                    ? false
                    : true,
                child: Container(
                  margin: controller.projectData[index].direction == "left"
                      ? const EdgeInsets.only(left: 10, top: 100)
                      : const EdgeInsets.only(right: 10, top: 100),
                  child: Column(
                    crossAxisAlignment:
                        controller.projectData[index].direction == "left"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          controller.projectData[index].name,
                          style: const TextStyle(
                              fontSize: 29, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Material(
                        elevation: 20,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff112742),
                            ),
                            width: MediaQuery.of(context).size.width / 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 12, 30, 12),
                              child: Text(
                                controller.projectData[index].description,
                                style: const TextStyle(),
                                softWrap: true,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          controller.projectData[index].technology,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: IconButton(
                            onPressed: () async {
                              await launchLink(
                                  controller.projectData[index].github);
                            },
                            icon: const ImageIcon(
                                size: 45,
                                color: Colors.white,
                                AssetImage("assets/github-icon.png"))),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
