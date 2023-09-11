import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/info.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/datamodels.dart';

class Details extends StatefulWidget {
  @override
  State<Details> createState() => DetailsState();
}

class DetailsState extends State<Details> {
  final dbHelper = DatabaseHelper.instance;
  bool isLoading = false;
  late List deviceGroup;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future refreshList() async {
    setState(() => isLoading = true);
    // surveyList = (await dbHelper.queryAllRow(table: customerTable))!;
    deviceGroup = await dbHelper.groupQuery(table: deviceTable, id: "id");
    // totalSight = await dbHelper.groupQuery(table: sightTable, id: "id");
    print(deviceGroup);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60, bottom: 20),
            alignment: Alignment.center,
            child: Text(
              "Name",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 8),
            child: Text(
              "address",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 8),
            child: Text(
              "email",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 8),
            child: Text(
              "phone",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 130, right: 130),
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
              "Label",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          isLoading == true
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.separated(
                    padding:
                        const EdgeInsets.only(top: 19, left: 24, right: 24),
                    itemCount: deviceGroup.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details()));
                        },
                        child: Container(
                          width: 341,
                          height: 120,
                          decoration: ShapeDecoration(
                            color:
                                Colors.black.withOpacity(0.05000000074505806),
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
                                    '${"name"}',
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
                                    '${"address"}',
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
                                left: 183,
                                top: 8,
                                child: SizedBox(
                                  width: 159,
                                  child: Text(
                                    '${"dateTime"}',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0x99363636),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.30,
                                    ),
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage("assets/icons/list.png"),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 7,
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
