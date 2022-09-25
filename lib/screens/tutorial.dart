import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  // late PullToRefreshController pullToRefreshController;
  InAppWebViewController? inAppWebViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  String searchedText = "";
  List allBookMarks = [];
  TextEditingController searchCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Tutorial Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                await inAppWebViewController!.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await inAppWebViewController!.reload();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () async {
              if (await inAppWebViewController!.canGoForward()) {
                await inAppWebViewController!.goForward();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 630,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.tutorialspoint.com"),
              ),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              // pullToRefreshController: pullToRefreshController,
              initialOptions: options,
              onLoadStop: (controller, url) {
                // pullToRefreshController.endRefreshing();
                setState(() {
                  searchCOntroller.text = url.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
