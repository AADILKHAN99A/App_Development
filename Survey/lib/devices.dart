import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/info.dart';
import 'package:survey/widgets/custom_textfield.dart';
import 'package:survey/sight.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => DevicesState();
}

class DevicesState extends State<Devices>
    with AutomaticKeepAliveClientMixin<Devices> {
//...........................Controller & Functions......................

  @override
  bool get wantKeepAlive => true;

  callback(parentIndex, index, panelName, sightNumber) {
    if (InfoState.sights[parentIndex]["devices"][index]["type"] == "panel") {
      setState(() {
        InfoState.sights[parentIndex]['devices'].insert(index + 1, {
          "sight": "sight $sightNumber",
          "label": "$panelName",
          "type": "tempPanel",
          "image": "",
          "information": "",
          "checked": false
        });

        if (kDebugMode) {
          print("Widget Added ${InfoState.sights[parentIndex]['devices']}");
        }
      });
    } else {
      setState(() {
        InfoState.sights[parentIndex]["devices"].removeAt(index);
        if (kDebugMode) {
          print("Widget Removed ${InfoState.sights}");
        }
      });
    }
  }

  File? image;

  Future pickImage(int parentIndex, int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() {
        InfoState.sights[parentIndex]["devices"][index]['image'] = image.path;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: InfoState.sights.length,
      itemBuilder: (BuildContext context, int parentIndex) {
        return parentIndex == SightState.display
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5, left: 155, right: 155),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        // margin: const EdgeInsets.only(bottom: 200),
                        child: Text(
                          "sight ${parentIndex + 1}",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          InfoState.sights[parentIndex]['devices'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                height: 35,
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: 38,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 15),
                                              child: Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                value: InfoState
                                                            .sights[parentIndex]
                                                        ["devices"][index]
                                                    ['checked'],
                                                onChanged: (value) {
                                                  setState(() {
                                                    InfoState.sights[
                                                                parentIndex]
                                                            ["devices"][index]
                                                        ["checked"] = value;
                                                  });
                                                },
                                                activeColor: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 35,
                                            top: 5,
                                            child: Text(
                                              InfoState.sights[parentIndex]
                                                  ["devices"][index]["label"],
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(
                                                          0.6000000238418579)),
                                            ),
                                          ),
                                          Positioned(
                                            right: 20,
                                            top: 5,
                                            child: InkWell(
                                              onTap: () {
                                                callback(
                                                    parentIndex,
                                                    index,
                                                    InfoState.sights[
                                                                parentIndex]
                                                            ["devices"][index]
                                                        ["label"],
                                                    InfoState.sights[
                                                                parentIndex]
                                                            ["devices"][index]
                                                        ["sight"]);
                                              },
                                              child: Row(
                                                children: [
                                                  InfoState.sights[parentIndex]
                                                                  ["devices"]
                                                              [index]['type'] ==
                                                          "panel"
                                                      ? const Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0x991D19DA),
                                                          size: 17,
                                                        )
                                                      : const Icon(Icons.remove,
                                                          color:
                                                              Color(0x991D19DA),
                                                          size: 17),
                                                  Text(
                                                      InfoState.sights[parentIndex]
                                                                          [
                                                                          "devices"]
                                                                      [index]
                                                                  ['type'] ==
                                                              "panel"
                                                          ? "Add"
                                                          : "",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: const Color(
                                                              0x991D19DA)))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 3, left: 55, right: 7),
                                      height: 45,
                                      decoration: ShapeDecoration(
                                          color: Colors.black
                                              .withOpacity(0.05000000074505806),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      child: CustomTextField(
                                        onChange: (value) {
                                          setState(() {
                                            InfoState.sights[parentIndex]
                                                    ["devices"][index]
                                                ["information"] = value;
                                          });
                                          log("Value: ${InfoState.sights[parentIndex]["devices"].toString()}");
                                        },
                                        enable: InfoState.sights[parentIndex]
                                            ["devices"][index]["checked"],
                                        hintText: "information",
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 45,
                                  height: 45,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(10),
                                        elevation: 0,
                                        backgroundColor: Colors.black
                                            .withOpacity(0.05000000074505806),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () =>
                                          pickImage(parentIndex, index),
                                      child: InfoState.sights[parentIndex]
                                                  ["devices"][index]['image'] !=
                                              ""
                                          ? Image.file(File(
                                              InfoState.sights[parentIndex]
                                                  ["devices"][index]['image']))
                                          : SvgPicture.asset(
                                              'assets/icons/camera.svg')),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                          width: 8,
                        );
                      },
                    )
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
