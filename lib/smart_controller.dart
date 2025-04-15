// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SmartController extends StatefulWidget {
  const SmartController({super.key});

  @override
  State<SmartController> createState() => _SmartControllerState();
}

class _SmartControllerState extends State<SmartController> {
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
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(fixedSize: ui.Size(150,150)),
                  child: Icon(Icons.device_thermostat, size: 60,)),
              SizedBox(width: 50),
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(fixedSize: ui.Size(150,150)),
                  child: Icon(Icons.light_mode_outlined, size: 60))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(fixedSize: ui.Size(150,150)),
                  child: Icon(Icons.lock, size: 60))
            ],
          ),
        ],
      ),
    );
  }
}
