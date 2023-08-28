import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/info.dart';
import 'package:survey/widgets/customtextfield.dart';

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

  callback(index, panelName, sightnumber) {
    if (InfoState.deviceList[index]['type'] == "panel") {
      setState(() {
        InfoState.deviceList.insert(index + 1, {
          "sight": sightnumber,
          "label": panelName,
          "type": "temppanel",
          "image": "",
          "information": "",
          "checked": false
        });
        print("Widget Added ${InfoState.deviceList}");
      });
    } else {
      setState(() {
        InfoState.deviceList.removeAt(index);
        print("Widget Removed ${InfoState.deviceList}");
      });
    }
  }

  File? image;

  Future pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() {
        InfoState.deviceList[index]["image"] = image.path;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: InfoState.deviceList.length,
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
                                padding:
                                    const EdgeInsets.only(left: 5, right: 15),
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  value: InfoState.deviceList[index]["checked"],
                                  onChanged: (value) {
                                    setState(() {
                                      InfoState.deviceList[index]["checked"] =
                                          value;
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
                                InfoState.deviceList[index]["label"],
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                        .withOpacity(0.6000000238418579)),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  callback(
                                      index,
                                      InfoState.deviceList[index]['label'],
                                      InfoState.deviceList[index]['sight']);
                                },
                                child: Row(
                                  children: [
                                    InfoState.deviceList[index]['type'] ==
                                            "panel"
                                        ? const Icon(
                                            Icons.add,
                                            color: Color(0x991D19DA),
                                            size: 17,
                                          )
                                        : const Icon(Icons.remove,
                                            color: Color(0x991D19DA), size: 17),
                                    Text(
                                        InfoState.deviceList[index]['type'] ==
                                                "panel"
                                            ? "Add"
                                            : "",
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0x991D19DA)))
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
                        margin:
                            const EdgeInsets.only(top: 3, left: 55, right: 7),
                        height: 45,
                        decoration: ShapeDecoration(
                            color:
                                Colors.black.withOpacity(0.05000000074505806),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: CustomTextField(
                          type: "",
                          onChange: (value) {
                            setState(() {
                              InfoState.deviceList[index]["information"] =
                                  value;
                            });
                            log("Value: ${InfoState.deviceList.toString()}");
                          },
                          enable: InfoState.deviceList[index]["checked"],
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
                          backgroundColor:
                              Colors.black.withOpacity(0.05000000074505806),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => pickImage(index),
                        child: InfoState.deviceList[index]['image'] != ""
                            ? Image.file(
                                File(InfoState.deviceList[index]['image']))
                            : SvgPicture.asset('assets/icons/camera.svg')),
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
      ),
    );
  }
}
