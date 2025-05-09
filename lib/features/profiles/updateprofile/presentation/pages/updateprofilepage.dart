import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:ulinmahoniapps/core/widgets/appbar.dart';
import '../../../../../core/layout/mainlayout.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

const List<String> gender = <String>["Male", "Female"];
class _UpdateProfileState extends State<UpdateProfile> {
  String genderValue = gender.first;
  TextEditingController _dateController = TextEditingController();
  Color forestGreenColor = Color(0xFF005F21);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      showBottomNav: true,
      showNavBar: false,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomAppBar(title: "Bio-data", showBackButton: true),
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/ulinhouse.jpg"),
              ),
              const SizedBox(height: 12),
              Text(
                "Vincent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                "vincent@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("What’s your first name?", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "First Name",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("And your last name?", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Last Name",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone number", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      initialCountryCode: "NG",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select your gender", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: genderValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          genderValue = newValue!;
                        });
                      },
                      items: gender
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("What is your date of birth?", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Date",
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: _selectDate,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: forestGreenColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Update Profile", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
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
      });
    }
  }
}
