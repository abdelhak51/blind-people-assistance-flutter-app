import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '/realtime/live_camera.dart';
import '/static_image/static.dart';

List<CameraDescription> cameras=[];

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  // running the app
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    )
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
 getcamera();
  }
  void getcamera() async
  {
    final camera = await availableCameras();

// Get a specific camera from the list of available cameras.
    final firstCamera = camera.first;
    cameras.add(firstCamera);
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: aboutDialog,
          ),
        ],
      ),
      body: Container(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 170,
                child: RaisedButton(
                  child: Text("Detect in Image"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StaticImage(),
                      ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: RaisedButton(
                  child: Text("Real Time Detection"),
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LiveFeed(cameras),
                      ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: ElevatedButton(
                  child: Text("speech"),
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LiveFeed(cameras),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  aboutDialog(){
     showAboutDialog(
      context: context,
      applicationName: "Object Detector App",
      applicationLegalese: "By Rupak Karki",
      applicationVersion: "1.0",
      children: <Widget>[
        Text("www.rupakkarki.com.np"),
      ],
    );
  }

}