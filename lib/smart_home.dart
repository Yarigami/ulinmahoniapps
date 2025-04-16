import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/smart_controller.dart';

class SmartHome extends StatefulWidget {
  const SmartHome({super.key});

  @override
  State<SmartHome> createState() => _SmartHomeState();
}

class _SmartHomeState extends State<SmartHome> {
  void _controllerPage(){
    Navigator.push(
        context,
      MaterialPageRoute(builder: (context) => const SmartController()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(onPressed: (){},
            child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(child: _smartHome())
        ],
      ),
    );
  }

  Widget _smartHome(){
    return ListView(
      children: [
        _smartCard(name: "Ulin Mahoni West Jakarta", type: "Alpha Room"),
      ],
    );
  }

  Widget _smartCard({
    required String name,
    required String type,
    })
    {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        minVerticalPadding: 16,
        contentPadding: const EdgeInsets.all(12),
        leading: SizedBox(
            width: 150,
            height: 150,
            child: Image.asset("assets/images/placeholder.png",
              fit: BoxFit.cover,)
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            Text(type),
            SizedBox(height: 4,),
            TextButton(onPressed: _controllerPage,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text("Controller"),
            ),
          ],
        ),
      ),
    );
  }
}
