import 'package:flutter/material.dart';

import 'Routes.dart';
main()  {
  runApp(Loading());
}
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController controller;
bool state=false;
  @override
  void initState() {

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addStatusListener((status) {
      if(status==AnimationStatus.completed){
       setState(() {
         state=true;
       });
      }
    })..forward();


    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
     !state? MaterialApp(
        home: Scaffold(

            body: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child:  FittedBox(
                  fit: BoxFit.cover,
                  child:
                Image.asset(
                    'assets/images/logo.png',
                ),)

            ),
          ),

      ):Routes();

  }
}
