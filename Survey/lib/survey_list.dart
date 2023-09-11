import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/datamodels.dart';
import 'package:survey/details.dart';
import 'package:survey/info.dart';
import 'package:survey/widgets/widgets.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({super.key});

  @override
  State<SurveyList> createState() => SurveyListState();
}

class SurveyListState extends State<SurveyList> {
//..............................Variables and Other Declarations................
  final dbHelper = DatabaseHelper.instance;
  late List<Map<String, dynamic>> surveyList;
  late List deviceGroup;
  late List totalSight;
  bool isLoading = false;
//................................Functions.....................................

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future refreshList() async {
    setState(() => isLoading = true);
    surveyList = (await dbHelper.queryAllRow(table: customerTable))!;
    deviceGroup = await dbHelper.groupQuery(table: deviceTable, id: "id");
    totalSight = await dbHelper.groupQuery(table: sightTable, id: "id");
    print(deviceGroup);

    setState(() {
      isLoading = false;
    });
  }

//...............................Database Query Functions.......................

  queryTable({required table}) async {
    var allRows = await dbHelper.queryAllRow(table: table);
    allRows!.forEach((row) {
      print(row);
    });
    return allRows;
  }

//.................................Survey List Screen...........................
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, bottom: 8),
              alignment: Alignment.center,
              child: Text(
                "Survey List",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            Positioned(
              right: 30,
              top: 48,
              child: IconButton(
                  onPressed: refreshList,
                  icon: const Icon(Icons.refresh_rounded)),
            )
          ],
        ),
        isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : surveyList.isEmpty
                ? SizedBox(
                    height: 610,
                    child: Center(
                      child: Text("List is Empty!",
                          style: GoogleFonts.poppins(
                              fontSize: 25, fontWeight: FontWeight.w600)),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      padding:
                          const EdgeInsets.only(top: 19, left: 24, right: 24),
                      itemCount: surveyList.length,
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
                                      '${surveyList[index]["name"]}',
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
                                      '${surveyList[index]["address"]}',
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
                                      '${surveyList[index]["dateTime"]}',
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
                                  left: 65,
                                  top: 85,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 94,
                                        child: Text(
                                          'Sights(${totalSight[index]['COUNT(*)']})',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xE0DF8430),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.32,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 94,
                                        child: Text(
                                          'Devices(${deviceGroup[index]['COUNT(*)']})',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xE0DF8430),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.32,
                                          ),
                                        ),
                                      )
                                    ],
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
                  ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Button(
            btnName: "Create Survey",
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            callback: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Info()));
            },
          ),
        )
      ],
    ));
  }
}
