

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class weSearch extends StatefulWidget {
  @override
  _weSearchState createState() => _weSearchState();
}

class _weSearchState extends State<weSearch> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OneStop"),),
      body:WebView(
        initialUrl: 'https://flutter.dev',
      )
    );
  }
}
