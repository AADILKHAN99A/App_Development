import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/datamodels.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  final int displayId;

  const Details({super.key, required this.displayId});

  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> with TickerProviderStateMixin {
  final dbHelper = DatabaseHelper.instance;
  bool isLoading = false;
  late List customerDetails;
  late List sightDetails;
  var deviceDetails = <List<Map<String, dynamic>>>[];
  PageController controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future refreshList() async {
    setState(() => isLoading = true);
    customerDetails = (await dbHelper.queryAllRow(
        table: customerTable, column: "_id", value: widget.displayId))!;
    sightDetails = (await dbHelper.queryAllRow(
        table: sightTable, column: "id", value: widget.displayId))!;
    for (int i = 0; i < sightDetails.length; i++) {
      deviceDetails.add((await dbHelper.queryAllRow(
          table: deviceTable,
          column: "id",
          value: sightDetails[i]['_sightId']))!);
    }
    if (kDebugMode) {
      print(customerDetails);
    }
    if (kDebugMode) {
      print(sightDetails);
    }
    if (kDebugMode) {
      print(deviceDetails);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 20),
          height: 40,
          child: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.05000000074505806),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  height: 150,
                  width: 375,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 75,
                        left: 10,
                        child: Text(
                          "${customerDetails[0]['address']}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Positioned(
                        bottom: 45,
                        left: 10,
                        child: Text(
                          "${customerDetails[0]['email']}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 15,
                        child: Text(
                          "${customerDetails[0]['phone']}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 15,
                        child: Text(
                          "${customerDetails[0]['dateTime']}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      Positioned(
                          right: 5,
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              dbHelper.delete(
                                  id: widget.displayId, table: customerTable);
                              Navigator.pop(context, true);
                            },
                            icon: const Icon(Icons.delete),
                          )),
                      Positioned(
                        right: 150,
                        top: 5,
                        child: Text(
                          "${customerDetails[0]['name']}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: PageView.builder(
                        onPageChanged: (num) {
                          setState(() {
                            currentPage = num;
                          });
                        },
                        controller: controller,
                        itemCount: sightDetails.length,
                        itemBuilder: (BuildContext context, int sightIndex) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 130, right: 130),
                                alignment: Alignment.center,
                                height: 30,
                                width: 80,
                                decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                // margin: const EdgeInsets.only(bottom: 200),
                                child: Text(
                                  "${sightDetails[sightIndex]['label']}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15),
                                decoration: ShapeDecoration(
                                  color: Colors.black
                                      .withOpacity(0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                height: 150,
                                width: 365,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 75,
                                      left: 10,
                                      child: Text(
                                        "${sightDetails[sightIndex]['address']}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 45,
                                      left: 10,
                                      child: Text(
                                        "${sightDetails[sightIndex]['email']}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      bottom: 15,
                                      child: Text(
                                        "${sightDetails[sightIndex]['phone']}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Positioned(
                                        right: 5,
                                        bottom: 10,
                                        child: IconButton(
                                          color: Colors.black,
                                          onPressed: () {
                                            if (sightDetails.length != 1) {
                                              dbHelper.delete(
                                                  id: sightDetails[sightIndex]
                                                      ['_sightId'],
                                                  table: sightTable);
                                            } else {
                                              dbHelper.delete(
                                                  id: widget.displayId,
                                                  table: customerTable);
                                              Navigator.pop(context, true);
                                            }

                                            refreshList();
                                            controller.jumpTo(currentPage - 1);
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.delete),
                                        )),
                                    Positioned(
                                      left: 15,
                                      top: 5,
                                      child: Text(
                                        "${sightDetails[sightIndex]['name']}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })),
                SizedBox(
                  width: 400,
                  height: 333,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 19, left: 24, right: 24),
                    itemCount: deviceDetails[currentPage].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 341,
                        height: 120,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.05000000074505806),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 65,
                              top: 34,
                              child: SizedBox(
                                width: 264,
                                child: Text(
                                  '${deviceDetails[currentPage][index]['label']}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black
                                          .withOpacity(0.8100000023841858),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.34),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 65,
                              top: 60,
                              child: SizedBox(
                                width: 264,
                                child: Text(
                                  '${deviceDetails[currentPage][index]['information']}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black
                                        .withOpacity(0.6000000238418579),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.32,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Positioned(
                                left: 11,
                                top: 37,
                                child: Container(
                                    height: 46,
                                    width: 46,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        color: Colors.white),
                                    child: deviceDetails[currentPage][index]
                                                ['image']
                                            .isEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                                'assets/icons/multiple-devices-svgrepo-com.svg'),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Image.file(File(
                                                "${deviceDetails[currentPage][index]['image']}")),
                                          )))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 7,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
