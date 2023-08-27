import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/widgets/customtextfield.dart';
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

  static List deviceList = [
    {
      "sight": 1,
      "label": "Panel information",
      "type": "panel",
      "image": "",
      "information": "",
      "checked": false
    },
    {
      "sight": 1,
      "label": "AC",
      "type": "panel",
      "image": "",
      "information": "",
      "checked": false
    },
    {
      "sight": 1,
      "label": "Heater information",
      "type": "panel",
      "image": "",
      "information": "",
      "checked": false
    },
    {
      "sight": 1,
      "label": "PowerX setup",
      "type": "panel",
      "image": "",
      "information": "",
      "checked": false
    },
  ];

  callback(index, panelName, sightnumber) {
    if (deviceList[index]['type'] == "panel") {
      setState(() {
        deviceList.insert(index + 1, {
          "sight": sightnumber,
          "label": panelName,
          "type": "temppanel",
          "image": "",
          "information": "",
          "checked": false
        });
        print("Widget Added $deviceList");
      });
    } else {
      setState(() {
        deviceList.removeAt(index);
        print("Widget Removed $deviceList");
      });
    }
  }

  sublistlength()
  {
    for(int i =0;i<deviceList.length;)
      {
        if(deviceList[i]['sight'] == 1)
          {

          }
      }

  }

  File? image;

  Future pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() {
        deviceList[index]["image"] = image.path;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
        itemCount: deviceList.length ~/ 4,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: deviceList.length,
              itemBuilder: (BuildContext context, int subindex) {
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
                                        value: deviceList[subindex]["checked"],
                                        onChanged: (value) {
                                          setState(() {
                                            deviceList[subindex]["checked"] =
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
                                      deviceList[subindex]["label"],
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
                                            subindex,
                                            deviceList[subindex]['label'],
                                            deviceList[subindex]['sight']);
                                      },
                                      child: Row(
                                        children: [
                                          deviceList[subindex]['type'] == "panel"
                                              ? const Icon(
                                                  Icons.add,
                                                  color: Color(0x991D19DA),
                                                  size: 17,
                                                )
                                              : const Icon(Icons.remove,
                                                  color: Color(0x991D19DA),
                                                  size: 17),
                                          Text(
                                              deviceList[subindex]['type'] ==
                                                      "panel"
                                                  ? "Add"
                                                  : "",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0x991D19DA)))
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
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: CustomTextField(
                                  onChange: (value) {
                                    setState(() {
                                      deviceList[subindex]["information"] = value;
                                    });
                                    log("Value: ${deviceList.toString()}");
                                  },
                                  enable: deviceList[subindex]["checked"],
                                  hintText: "information")),
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
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () => pickImage(subindex),
                              child: deviceList[subindex]['image'] != ""
                                  ? Image.file(File(deviceList[subindex]['image']))
                                  : SvgPicture.asset(
                                      'assets/icons/camera.svg')),
                        )
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int subindex) {
                return const SizedBox(
                  height: 10,
                  width: 8,
                );
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              width: 30,
              decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              // margin: const EdgeInsets.only(bottom: 200),
              child: Text(
                "$index",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          );
        });
  }
}
