import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';


class VimeoplayerView extends StatefulWidget {
  const VimeoplayerView({super.key});

  @override
  State<VimeoplayerView> createState() => _VimeoplayerViewState();
}

class _VimeoplayerViewState extends State<VimeoplayerView> {

  bool isVideoLoading = true;

  /// Controller of the WebView
  InAppWebViewController? webViewController;


  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title:  Text("Vimeo Player"),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white
      ),
      body:
      VimeoVideoPlayer(
        videoId: '12860646',
        isAutoPlay: true,
        onInAppWebViewCreated: (controller) {
          webViewController = controller;
        },
        onInAppWebViewLoadStart: (controller, url) {
          setState(() {
            isVideoLoading = true;
          });
        },
        onInAppWebViewLoadStop: (controller, url) {
          setState(() {
            isVideoLoading = false;
          });
        },)
    );
  }
}
