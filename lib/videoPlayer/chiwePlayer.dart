import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class Chiweplayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const Chiweplayer({super.key,required this.videoPlayerController});

  @override
  State<Chiweplayer> createState() => _ChiweplayerState();
}

class _ChiweplayerState extends State<Chiweplayer> {
    ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    widget.videoPlayerController.initialize();
    chewieController = ChewieController(videoPlayerController: widget.videoPlayerController,
    looping: true,
      aspectRatio: 16/9,
      autoInitialize: false
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.videoPlayerController.pause();
    chewieController?.dispose();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: const Text("Chewie Player"),
      backgroundColor: Colors.green,
      automaticallyImplyLeading: true,
      foregroundColor: Colors.white
      ),
      body: Chewie(controller: chewieController!,),
    );
  }
}
