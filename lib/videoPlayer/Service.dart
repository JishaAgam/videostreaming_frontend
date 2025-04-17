import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIService{

  Future<dynamic> callVideo() async{
    try{
      String urlString =
          "http://44.211.226.39//video/stream_vid/mixkit-stars-in-space-background-1610-hd-ready.mp4";
          // "http://192.168.1.13:5000/video/stream_vid/mixkit-stars-in-space-background-1610-hd-ready.mp4";
      final response  = await http.get(Uri.parse(urlString));
      print("response ${jsonDecode(response.body).toString()}");
      print("response ${response.statusCode}");

    }
        catch (e){
          print("response ${e}");
        }
  }




  // Future<dynamic> uploadVideo(String? fileName,String? file) async{
  //   try{
  //     final uri  =
  //     Uri.parse("http://192.168.1.13:5000/video/upload");
  //     final request = http.MultipartRequest("POST", uri)
  //     ..fields['filename'] = fileName!
  //   ..files.add(await http.MultipartFile.fromPath("video", file!,
  //     ));
  //     var response = await request.send();
  //     final respStr = await response.stream.bytesToString();
  //     print("response ${response.statusCode}");
  //     print("respStr ${respStr}");
  //     final result = jsonDecode(respStr);
  //     if (response.statusCode == 200) {
  //       Get.showSnackbar(
  //         const GetSnackBar(
  //           title: "Uploaded 🎉",
  //           message: "Your video has been successfully uploaded!",
  //           backgroundColor: Colors.green,
  //           icon: Icon(Icons.check_circle, color: Colors.white),
  //           duration: Duration(seconds: 3),
  //           snackPosition: SnackPosition.TOP,
  //           margin: EdgeInsets.all(10),
  //           borderRadius: 8,
  //         ),
  //       );
  //
  //       print('Upload successful');
  //     } else {
  //       print('Upload failed: ${response.statusCode}');
  //     }
  //
  //   }
  //       catch (e){
  //         print('Error $e');
  //       }
  // }

}