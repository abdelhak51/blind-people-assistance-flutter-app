import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


void main() {
  runApp(TextToSpeechApp());
}

  class TextToSpeechApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  }

  class _MyAppState extends State<TextToSpeechApp> {
bool _islistening=false;
String _text='';
double _confidence=0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey,
            title:Text(
                'Blind Assistance'
            )),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                Text('Welcome to the prototype of our solution that concerns blind peoples',style: TextStyle(
                  fontSize: 19,fontFamily: 'Quicksand',fontWeight: FontWeight.bold,color: Colors.black
              )),
                  SizedBox(height: 10,),
                 Align(
                   alignment: Alignment.topLeft,
                   child: Text('This Application work only using Speech Recognition commands:',
                       style: TextStyle(
                           fontSize: 18,fontFamily: 'Quicksand',fontWeight: FontWeight.bold,color: Colors.black)),
                 ) ,
                  SizedBox(height: 25,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(

                      children: [
                        Text('The Commands:',style:TextStyle(

                            fontSize: 18,fontFamily: 'Quicksand',fontWeight: FontWeight.bold,color: Colors.black)),
                        SizedBox(height: 10,),

                        Align(
                          alignment: Alignment.topLeft,

                          child: Text("-'Extraction' --> Extraction of a text in a document",style: TextStyle(
                              fontSize: 18,fontFamily: 'Quicksand',color: Colors.black)),
                        ),

                       Align(
                           alignment: Alignment.topLeft,
                           child: Text("-'Obstacle' --> Detection of obstacles",style: TextStyle(
                            fontSize: 18,fontFamily: 'Quicksand',color: Colors.black))
                       ),


                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("-'Quit' --> To Quit the Application",style: TextStyle(
                            fontSize: 18,fontFamily: 'Quicksand',color: Colors.black))),
                        SizedBox(height: 10,)
                      ],
                    ),
                  )

                ],
              )

              ),
            Center(
                child:
                ElevatedButton(
                  onPressed: () async{

                    setState(() {
                      _islistening=true;
                    });
                    stt.SpeechToText speech = stt.SpeechToText();
                    bool available = await speech.initialize( onStatus: (val)=>print('onStatus: $val'), onError: (error)=>print('onError: $error') );
                    if ( available ) {
                      print(' availble');
                      speech.listen( onResult: (val)=>setState(() {
                        _text=val.recognizedWords;
                        _text=_text.toLowerCase();
                        print(_text);
                        if(val.hasConfidenceRating && val.confidence>0){
                          _confidence=val.confidence;
                        }
                        if(_text=='extraction'){
                          Navigator.pushNamed(context, '/speech');
                        }
                        if(_text=='obstacle'){
                          Navigator.pushNamed(context, '/object');

                        }
                      }),
                      );
                    }
                    else {
                      setState(() {
                        _islistening=false;
                        speech.stop();
                      });
                      print("The user has denied the use of speech recognition.");
                    }
                  },
                  child: Icon(!_islistening?Icons.mic :Icons.mic_none, color: Colors.white,size: 90,),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(

                    ),
                    padding: EdgeInsets.all(80),
                    primary: Colors.green, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                )


            )
          ],
        ));
  }
}
