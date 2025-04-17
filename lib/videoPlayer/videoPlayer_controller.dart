import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController{
   RxString? title = "Video Player".obs;
   RxString pathName = "".obs;
   late VideoPlayerController videoPlayerController;
   RxBool isInitialized = false.obs;
   RxBool isPlay = false.obs;

   RxList<dynamic> items = [].obs;
   Uint8List? thumbnailBytes;

@override
  void onInit() {
    super.onInit();
    pathName = "".obs;
    // videoPlayerController = VideoPlayerController.networkUrl(
    //    Uri.parse(
    //      "https://v.ftcdn.net/04/15/69/72/700_F_415697290_zBlJFddKioqUgBBlebfKHHd9QQNJadQQ_ST.mp4"
    //      // "https://assets.mixkit.co/videos/51585/51585-720.mp4"
    //        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
    //    ),
    // );
    
    // videoPlayerController = VideoPlayerController.contentUri(
    //     Uri.parse("https://www.freepik.com/premium-video/river-water-flowing"
    //         "-with-boulders-rocks-pine-tree-forest_535224#fromView=search&page=1&position=26&uuid=8d04ce1a-c5f7-403f-a2b8-1f7e54dc00f5"));
    //
    // videoPlayerController = VideoPlayerController.network(
    //   "https://www.freepik.com/premium-video/river-water-flowing-with-boulders-rocks-pine-tree-forest_535224"
    //   // "https://videocdn.cdnpk.net/videos/cae8411f-77f2-56ab-a9bf-96898973099d/horizontal/previews/watermarked/large.mp4"
    //   // "https://videocdn.cdnpk.net/videos/5175cb0e-252c-4f41-bc0d-acae8131a3eb/horizontal/previews/watermarked/large.mp4"
    //   // "https://www.freepik.com/premium-video/river-water-flowing"
    //   //     "-with-boulders-rocks-pine-tree-forest_535224#fromView=search&page=1&position=26&uuid=8d04ce1a-c5f7-403f-a2b8-1f7e54dc00f5"
    //     // "https://v.ftcdn.net/04/15/69/72/700_F_415697290_zBlJFddKioqUgBBlebfKHHd9QQNJadQQ_ST.mp4"
    // );
    //
    // videoPlayerController.initialize().then((_) {
    //    // isInitialized.value = true;
    //    videoPlayerController.play();
    //    isPlay.value = true;
    //    update();
    // });
    loadJson();
    callChewiePlayer();
  }

  displayVideo(String? urlVideo) async{
    videoPlayerController = VideoPlayerController.network(urlVideo!)
      ..initialize().then((value) => update());
  }

   void initialize(String url) {
     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

     videoPlayerController.initialize().then((_) {
       isInitialized.value = true;
       videoPlayerController.play();
       update();
     });
   }

 callChewiePlayer() async {
   callVideo();
  return videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4'
      ));

  // return videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
   update();
}

   // Future<void> callVideo() async {
   //   pathName.value ="";
   //   final dir = await getTemporaryDirectory();
   //   // final dir = await getApplicationSupportDirectory();
   //
   //   XFile thumbnailFile = await VideoThumbnail.thumbnailFile(
   //     video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
   //     thumbnailPath: dir.path,
   //     imageFormat: ImageFormat.PNG,
   //     maxHeight: 150,
   //     quality: 100,
   //   );
   //
   //   if (thumbnailFile != null) {
   //     pathName.value = thumbnailFile.path;
   //     update();
   //     print("📷 Thumbnail saved at: $thumbnailFile");
   //   } else {
   //     print("❌ Failed to generate thumbnail");
   //   }
   //
   // }


   Future<void> callVideo() async {
     pathName.value = "";
     // final dir = await getTemporaryDirectory();
     final dir = await getApplicationDocumentsDirectory();

     final XFile thumbnailFilePath = await VideoThumbnail.thumbnailFile(
       video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
       thumbnailPath: dir.path,
       imageFormat: ImageFormat.PNG,
       maxHeight: 150,
       quality: 100,
     );

     if (thumbnailFilePath != null) {
       pathName.value = thumbnailFilePath!.path;
       update();
       print("📷 Thumbnail saved at: $thumbnailFilePath");
     } else {
       print("❌ Failed to generate thumbnail");
     }
   }



   Future<void> loadJson() async {
     final String response = await rootBundle.loadString('assets/videos.json');
     final data = json.decode(response);
     items.addAll(data);
     isInitialized.value = true;
     print("items ${data[0]['title']}"); // Output: Flutter is awesome
   }

   void togglePlayPause() {

      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
        isPlay.value = false;

      }else if(  videoPlayerController.value.isCompleted){
        videoPlayerController.pause();
        isPlay.value = false;
      }
      else {
        isPlay.value = true;
         videoPlayerController.play();

      }
      update();
   }

   void fullScreen(){
     videoPlayerController.videoPlayerOptions?.webOptions?.controls.allowFullscreen;
   }

   @override
   void onClose() {
      videoPlayerController.dispose();
      super.onClose();
   }
}