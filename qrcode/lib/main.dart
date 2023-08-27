import 'package:flutter/material.dart';

void main()
{
  runApp(QRCode());
}

class QRCode extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(

          backgroundColor: Colors.purple[900],
          title: Center(child: Text("My QR App",style: TextStyle(fontWeight: FontWeight.w500))),
        ),
        body: Center(
          child: Card(
            color: Colors.purple,
            child: Image.asset("assets/frame.png",
            height: 350,
            ),
          ),
        ),
      ),
    );
  }

}