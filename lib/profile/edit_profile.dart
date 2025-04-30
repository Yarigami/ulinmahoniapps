import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'my_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

const List<String> gender = <String>["Male", "Female"];
class _ProfilePageState extends State<ProfilePage> {
  String genderValue = gender.first;
  TextEditingController _dateController = TextEditingController();

  void _myProfile(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Bio-data",),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    // backgroundColor: Colors.green,
                    backgroundImage: AssetImage("assets/images/placeholder.png"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("User@gmail.com", style: TextStyle(color: Colors.grey),),
                ],
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0),
                // padding: const EdgeInsets.all(32.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "First Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0),
                // padding: const EdgeInsets.all(32.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Last Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0),
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    counterText: "",
                  ),
                  initialCountryCode: "ID",
                  inputFormatters: [],// max number of input
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0 ),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Gender",
                  ),
                  value: genderValue,
                  onChanged: (String? newValue){
                    setState(() {
                      genderValue = newValue!;
                    });
                  },
                  // item list
                  items: gender.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0),
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Birth Date",
                    prefixIcon: Icon(Icons.calendar_today),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide()
                    // )
                  ),
                  readOnly: true,
                  onTap: (){
                    _selectDate();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SizedBox(
                  width: 200,
                  height: 60,
                  child: TextButton(
                    onPressed: _myProfile,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async{
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (_picked != null){
      String dateFormat = DateFormat('dd-MM-yyyy').format(_picked);
      setState(() {
        _dateController.text = dateFormat;
        // _dateController.text = DateFormat('yyyy-MM-dd').format(_picked);
      });
    }
  }
}
