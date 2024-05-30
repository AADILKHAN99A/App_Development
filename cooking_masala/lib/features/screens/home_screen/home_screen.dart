import 'package:cooking_masala/core/utils/color_constants.dart';
import 'package:cooking_masala/core/utils/link_contants.dart';
import 'package:cooking_masala/features/screens/home_screen/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController controller;

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            icon: const Icon(Icons.warning_amber, color:   Color(darkGrey)),
            title: const Text(
              "Do you want to exit the App?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(darkGrey)),
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:  const Color(darkGrey)),
                  onPressed: () => Navigator.pop(context, true),
                  child:
                      const Text("Yes", style: TextStyle(color: Colors.white)))
            ],
          ));

  @override
  void initState() {
    // TODO: implement initState

    var provider = Provider.of<HomeScreenProvider>(context, listen: false);
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000)).ignore()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            provider.setProgress(progress);
          },
          onPageStarted: (String url) {
            provider.setProgress(0);
          },
          onPageFinished: (String url) {
            provider.setProgress(100);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(baseUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        final shouldPop = await showWarning(context);
        if (shouldPop == true) {
          SystemNavigator.pop();
        }

      },
      child: SafeArea(child:
          Consumer<HomeScreenProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (provider.progress < 100)
                Center(
                  child: CircularProgressIndicator(
                    value: provider.progress / 100.0,
                  ),
                )
            ],
          ),
        );
      })),
    );
  }
}
