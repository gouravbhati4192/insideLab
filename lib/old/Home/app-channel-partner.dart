import 'dart:convert';

import 'package:financial_freedom/main.dart';
import 'package:financial_freedom/old/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppChannelPartner extends StatefulWidget {
  final String agentName;
  const AppChannelPartner({Key key, this.agentName}) : super(key: key);

  @override
  _AppChannelPartnerState createState() => _AppChannelPartnerState();
}

class _AppChannelPartnerState extends State<AppChannelPartner> {
  // bool _isLoading = true;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Channel Partner Agreement'),
  //     ),
  //     body: LoadingOverlay(
  //       isLoading: _isLoading,
  //       child: Center(
  //         child: SfPdfViewer.network(
  //           "https://www.insiderlab.in/app-channel-partner.pdf",
  //           onDocumentLoaded: (data) {
  //             setState(() {
  //               _isLoading = false;
  //             });
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  WebViewController _webViewController;
  String filePath;

  @override
  void initState() {
    super.initState();
    filePath = [
      "assets/html/app-channel-partner-plus.html",
      "assets/html/app-channel-partner.html",
      "assets/html/app-channel-partner-individual.html"
    ][slab - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'App Channel Partner',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    fileHtmlContents = fileHtmlContents.replaceFirst(
        "The User of the Mobile App",
        (widget.agentName ??
                (HomeState.agentName.value.toString().toUpperCase() ?? "")) +
            " ");
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
