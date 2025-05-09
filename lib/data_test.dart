import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/listData.dart';
import 'booking/my_booking.dart';

class DataTest extends StatefulWidget {
  const DataTest({super.key});

  @override
  State<DataTest> createState() => _DataTestState();
}

class _DataTestState extends State<DataTest> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController hpmController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();

  final List<ListData> dataList = [];

  DateTime? checkInDate;
  DateTime? checkOutDate;

  void submitData() {
    try {
      final name = nameController.text;
      final type = typeController.text;
      final hpm = double.parse(hpmController.text);
      final duration = int.parse(durationController.text);
      final discount = double.parse(discountController.text);
      final checkIn = checkInDate!;
      final checkOut = checkOutDate!;

      final total = hpm * duration;
      final ftotal = total - (total * discount);
      // final status = "completed";

      final newItem = ListData(
        image: "assets/images/house.png",
        name: name,
        type: type,
        checkIn: checkIn,
        checkOut: checkOut,
        hpm: hpm,
        duration: duration,
        total: total,
        discount: discount,
        ftotal: ftotal,
        // status: status
      );

      setState(() {
        dataList.add(newItem);
        // Navigator.pop(context, dataList);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBooking(data: dataList),
          ),
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data saved successfully!")),
      );
      //
      // nameController.clear();
      // typeController.clear();
      // hpmController.clear();
      // durationController.clear();
      // discountController.clear();
      // checkInController.clear();
      // checkOutController.clear();
      // checkInDate = null;
      // checkOutDate = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid input or missing date.")),
      );
    }
  }

  Future<void> _selectDate(TextEditingController controller, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  Widget buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget buildDateField(String label, TextEditingController controller, bool isCheckIn) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(controller, isCheckIn),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField('Name', nameController),
              buildTextField('Type', typeController),
              buildTextField('HPM', hpmController, keyboardType: TextInputType.number),
              buildTextField('Duration', durationController, keyboardType: TextInputType.number),
              buildTextField('Discount', discountController, keyboardType: TextInputType.number),
              buildDateField('Check-In Date', checkInController, true),
              buildDateField('Check-Out Date', checkOutController, false),
              // buildDateField('Status', checkOutController, false),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
