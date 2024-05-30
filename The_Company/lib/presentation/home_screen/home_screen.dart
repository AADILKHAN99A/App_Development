import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback callback;
  final VoidCallback rechargeCallBack;
  final VoidCallback withdrawlCallBack;
  final String phone;

  const HomeScreen(
      {super.key,
        required this.callback,
        required this.rechargeCallBack,
        required this.withdrawlCallBack,
        required this.phone});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  _launchURL() async {
    // const url = 'https://wa.me/message/DWWW4XFPTJQQC1';
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  _launchURLTg() async {
    // const url = 'https://t.me/omegaearnapp';
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  _launchURLEmail() async {
    String email = 'business.omegainvestments@gmail.com';
    String subject = 'This is a test email';
    String body = 'This is a test email body';

    String url = "mailto:$email?subject=$subject&body=$body";
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // final newsList = [
  //   {
  //     "image": "omegahome.png",
  //     "headline": "PLANET OMEGA IN NEW YORK",
  //     "detail":
  //         "The story of OMEGA has gone on display at a special exhibition at the Chelsea Factory in New York City. Planet OMEGA showcases many of the most innovative timepieces and memorable partnerships that make our brand so renowned across the world."
  //   },
  //   {
  //     "image": 'omegahome1.png',
  //     "headline": "THE PARIS 2024 COUNTDOWN CLOCK",
  //     "detail":
  //         "Discover the one-year countdown to next year’s Olympic Games, as OMEGA measures the hours, minutes, and seconds in the host city."
  //   },
  // ];
  List<String> images = [
    "assets/image3.webp",
    "assets/image4.jpg",
    "assets/image5.jpg"
  ];

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  int activePage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pageController = PageController(viewportFraction: 1, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _launchURL();
          },
          child: const Icon(
            Icons.support_agent_outlined,
            size: 35,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
                height: 260,
                width: double.infinity,
                // child: CarouselSlider(
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     viewportFraction: 1,
                //     height: 260.0,
                //     enlargeCenterPage: true,
                //     onPageChanged: (position, reason) {
                //       activePage = position;
                //       setState(() {});
                //     },
                //     enableInfiniteScroll: true,
                //   ),
                //   items: [0, 1, 2].map<Widget>((i) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Container(
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: AssetImage(images[i]))));
                //       },
                //     );
                //   }).toList(),
                // )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(images.length, activePage),
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const Row(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.blue,
                    ),
                    Text(
                      "Welcome, we're glad you're here, where you can Shop",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (builder) => RechargePage(
                            //           phone: widget.phone,
                            //         )));
                          },
                          icon: Image.asset(
                            "assets/recharge.png",
                            scale: 4,
                          )),
                      Text("the pay".tr)
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.rechargeCallBack();
                            });
                          },
                          icon: Image.asset(
                            "assets/brands.png",
                            scale: 7,
                          )),
                      Text("brands".tr)
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.withdrawlCallBack();
                            });
                          },
                          icon: Image.asset(
                            "assets/withdrawl.png",
                            scale: 8,
                          )),
                      Text("withdraw".tr)
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             widget.callback();
                  //           });
                  //         },
                  //         icon: Image.asset(
                  //           "assets/invite.png",
                  //           scale: 4,
                  //         )),
                  //     const Text("Invite")
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Column(
                  //   children: [
                  //     IconButton(
                  //         onPressed: _launchURL,
                  //         icon: Image.asset(
                  //           "assets/Customer.png",
                  //           scale: 4,
                  //         )),
                  //     const Text("Customer")
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           if (PWAInstall().installPromptEnabled) {
                  //             try {
                  //               PWAInstall().promptInstall_();
                  //             } catch (e) {
                  //               setState(() {
                  //                 print(e);
                  //               });
                  //             }
                  //           } else {
                  //             print('Already install');
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               SnackBar(
                  //                 width: 200,
                  //                 backgroundColor:
                  //                     Theme.of(context).colorScheme.secondary,
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                 ),
                  //                 behavior: SnackBarBehavior.floating,
                  //                 content:
                  //                     const Text("App is already installed!"),
                  //               ),
                  //             );
                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               SnackBar(
                  //                 width: 200,
                  //                 backgroundColor:
                  //                     Theme.of(context).colorScheme.secondary,
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                 ),
                  //                 behavior: SnackBarBehavior.floating,
                  //                 content:
                  //                     const Text("or app does not support"),
                  //               ),
                  //             );
                  //           }
                  //         },
                  //         icon: Image.asset(
                  //           "assets/download.png",
                  //           scale: 4,
                  //         )),
                  //     const Text("Download")
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     IconButton(
                  //         onPressed: _launchURLEmail,
                  //         icon: Image.asset(
                  //           "assets/CustomerCare.png",
                  //           scale: 4,
                  //         )),
                  //     const Text("Customer Care")
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: const Divider(
                  thickness: 1,
                )),
            // Container(
            //   margin: const EdgeInsets.only(left: 20),
            //   child: Row(
            //     children: [
            //       Image.asset('assets/helpline.png', scale: 4),
            //       InkWell(
            //         onTap: _launchURLTg,
            //         child: const Text(
            //           "Service complaints Telegram",
            //           style: TextStyle(
            //               color: Colors.green,
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //       const Icon(
            //         Icons.chevron_right,
            //         color: Colors.green,
            //       )
            //     ],
            //   ),
            // ),
            // const Text(
            //   "News Notice",
            //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            // ),
            // Expanded(
            //   child: SizedBox(
            //     height: 200,
            //     width: double.infinity,
            //     child: ListView.builder(
            //         itemCount: newsList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return SizedBox(
            //             width: double.infinity,
            //             child: Card(
            //               color: Colors.transparent,
            //               shadowColor: Colors.deepOrange[200],
            //               surfaceTintColor: Colors.deepOrange[100],
            //               margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   Text(
            //                     "${newsList[index]["headline"]}",
            //                     style: const TextStyle(fontWeight: FontWeight.w800),
            //                   ),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       CircleAvatar(
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(50),
            //                           child: Image.asset(
            //                             'assets/${newsList[index]["image"]}',
            //                           ),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Text(
            //                           "${newsList[index]["detail"]}",
            //                           maxLines: 3,
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                       )
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         }),
            //   ),
            // )
          ],
        ));
  }
}
