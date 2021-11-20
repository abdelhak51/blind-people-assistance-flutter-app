


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/main.dart';
import 'package:text_to_speech/realtime/live_camera.dart';
import 'package:text_to_speech/realtime/textRecognition.dart';

List<CameraDescription> cameras=[];


main()  {
  runApp(Routes());
}


class Routes extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}
class _MyAppState extends State<Routes> {
  @override
  void initState(){
    getcamera();
  }
  void getcamera() async
  {
    final camera = await availableCameras();

// Get a specific camera from the list of available cameras.
    final firstCamera = camera.first;
    print('adsa');
    cameras.add(firstCamera);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange, accentColor: Colors.orange),
      initialRoute: '/',
      routes: {
        '/speech':(context)=>textRecognition(),
        '/object':(context)=>LiveFeed(cameras)
      },
      home:TextToSpeechApp(),
    );
  }




}