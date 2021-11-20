
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class textRecognition extends StatefulWidget {
  const textRecognition({Key? key}) : super(key: key);

  @override
  _textRecognitionState createState() => _textRecognitionState();
}


class _textRecognitionState extends State<textRecognition> {
  FlutterTts flutterTts = FlutterTts();
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  List<String> _text = [];

  @override
void initState()  {
launchTextR();
}
Future<void> launchTextR() async{
  List<OcrText> texts = [];
  try {
    texts = await FlutterMobileVision.read(
      camera: _ocrCamera,
      waitTap: true,

    );
    setState(() {
      _text.add(texts[0].value);
      print('text');
      for(String t in _text){
        playColorName(t);

      }

    });
  } on Exception {
    texts.add( OcrText('Failed to recognize text'));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Extraction"),
      ),
      body: Center(
        child:_text.length==0? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ):
        Column(
          children: [
            Padding(padding: EdgeInsets.all(10),
            child:Text('All the Text Detected:',

                style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                ))
            )
            ,ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
          itemCount: _text.length,
          itemBuilder: (context, index) => Card(
            elevation: 6,
            margin: EdgeInsets.all(10),
            child: ListTile(

              title: Text(_text[index]),
            ),
          ),
        )
          ],
        )));
  }
  void playColorName(String colorName) async {
    await flutterTts.speak(colorName);
  }
  void stopR() async{
    await flutterTts.stop();
  }
}






