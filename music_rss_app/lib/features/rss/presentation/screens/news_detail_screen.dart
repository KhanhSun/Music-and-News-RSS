import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatelessWidget {
  final String url;

  const NewsDetailScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(),

      body: WebViewWidget(controller: controller),
    );
  }
}
