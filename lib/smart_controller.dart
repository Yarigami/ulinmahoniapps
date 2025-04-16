import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SmartController extends StatefulWidget {
  const SmartController({super.key});

  @override
  State<SmartController> createState() => _SmartControllerState();
}

class _SmartControllerState extends State<SmartController> {
  bool tempPressed = false;
  bool lightPressed = false;
  bool lockPressed = false;
  Color tempColor = Colors.grey.shade200;
  Color lightColor = Colors.grey.shade200;
  Color lockColor = Colors.grey.shade200;

  void _tempPressed(){
    setState(() {
      tempPressed = !tempPressed;
      tempColor = tempPressed ? Colors.green.shade400 : Colors.grey.shade200;
    });
  }

  void _lightPressed(){
    setState(() {
      lightPressed = !lightPressed;
      lightColor = lightPressed ? Colors.green.shade400 : Colors.grey.shade200;
    });
  }

  void _lockPressed(){
    setState(() {
      lockPressed = !lockPressed;
      lockColor = lockPressed ? Colors.green.shade400 : Colors.grey.shade200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: (){},
          child: Icon(Icons.arrow_back_ios, color: Colors.white,)
        ),
          backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              ElevatedButton(onPressed: _tempPressed,
                  style: ElevatedButton.styleFrom(
                    fixedSize: ui.Size(150,150),
                    backgroundColor: tempColor,
                  ),
                  child: Icon(Icons.device_thermostat, size: 60,)),
              SizedBox(width: 50),
              ElevatedButton(onPressed: _lightPressed,
                  style: ElevatedButton.styleFrom(
                    fixedSize: ui.Size(150,150),
                    backgroundColor: lightColor,
                  ),
                  child: Icon(Icons.light_mode_outlined, size: 60))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: _lockPressed,
                  style: ElevatedButton.styleFrom(
                    fixedSize: ui.Size(150,150),
                    backgroundColor: lockColor,
                  ),
                  child: Icon(Icons.lock, size: 60))
            ],
          ),
        ],
      ),
    );
  }
}
