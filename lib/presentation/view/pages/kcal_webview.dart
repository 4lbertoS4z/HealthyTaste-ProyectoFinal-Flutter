import 'package:flutter/material.dart';
import 'package:healthy_taste/data/remote/network_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KcalWebView extends StatefulWidget {
  const KcalWebView({super.key});

  @override
  State<KcalWebView> createState() => _KcalWebViewState();
}

class _KcalWebViewState extends State<KcalWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(NetworkConstants.KCAL_CALCULATOR_PATH));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kcal WebView')),
      body: WebViewWidget(controller: controller),
    );
  }
}
