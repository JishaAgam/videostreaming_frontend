import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService{

  Future<dynamic> callVideo() async{
    try{
      String urlString = "http://192.168.1.13:5000/video/stream_vid/mixkit-stars-in-space-background-1610-hd-ready.mp4";
      final response  = await http.get(Uri.parse(urlString));
      print("response ${jsonDecode(response.body).toString()}");
      print("response ${response.statusCode}");

    }
        catch (e){
          print("response ${e}");
        }
  }

}