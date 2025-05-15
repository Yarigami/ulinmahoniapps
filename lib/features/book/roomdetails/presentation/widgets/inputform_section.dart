import 'package:flutter/material.dart';

class RoomInputSection extends StatelessWidget {
  final String? rentType;
  final int? duration;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final TextEditingController checkInDateController;
  final TextEditingController checkOutDateController;
  final Function(String?) onRentTypeChanged;
  final Function(int?) onDurationChanged;
  final VoidCallback onSelectCheckInDate;

  const RoomInputSection({
    Key? key,
    required this.rentType,
    required this.duration,
    required this.checkInDate,
    required this.checkOutDate,
    required this.checkInDateController,
    required this.checkOutDateController,
    required this.onRentTypeChanged,
    required this.onDurationChanged,
    required this.onSelectCheckInDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRentTypeInput(),
        const SizedBox(height: 16),
        buildDurationInput(),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onSelectCheckInDate,
          child: AbsorbPointer(
            child: buildDateInput('Check-in', checkInDateController),
          ),
        ),
        const SizedBox(height: 16),
        buildCheckoutDateInput('Check Out', checkOutDateController),
      ],
    );
  }

  Widget buildRentTypeInput() {
    return DropdownButtonFormField<String>(
      value: rentType,
      items: ['daily', 'monthly']
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: const InputDecoration(labelText: 'Rent Type'),
      onChanged: onRentTypeChanged,
    );
  }

  Widget buildDurationInput() {
    int maxDuration = rentType == 'daily' ? 30 : 12;
    List<int> durationOptions = List.generate(maxDuration, (index) => index + 1);

    return DropdownButtonFormField<int>(
      value: duration,
      items: durationOptions
          .map((value) => DropdownMenuItem(value: value, child: Text(value.toString())))
          .toList(),
      decoration: InputDecoration(
        labelText: 'Duration (${rentType == 'monthly' ? 'months' : 'days'})',
      ),
      onChanged: rentType == null ? null : onDurationChanged,
    );
  }

  Widget buildDateInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Pilih tanggal",
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget buildCheckoutDateInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Otomatis terisi",
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }
}


