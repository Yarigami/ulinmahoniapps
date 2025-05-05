import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SearchFilterModal extends StatefulWidget {
  const SearchFilterModal({super.key});

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  String selectedCategory = 'Housing';
  String selectedRentType = 'Monthly';

  int? durationRaw;
  DateTime? checkInDate;
  int? durationInDays;

  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();

  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  List<String> getRentTypeOptions(String category) {
    if (category == 'Hotel' || category == 'Villa') {
      return ['Daily'];
    } else {
      return ['Monthly', 'Daily'];
    }
  }

  Future<void> _selectCheckInDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF005F21), // Tombol dan tanggal terpilih
              onPrimary: Colors.white,    // Teks di atas warna primer
              surface: Colors.white,      // Background kalender
              onSurface: Colors.black,    // Teks biasa
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        checkInDate = picked;
        _checkInController.text = DateFormat('dd-MM-yyyy').format(picked);

        if (durationInDays != null) {
          final checkOutDate = picked.add(Duration(days: durationInDays!));
          _checkOutController.text =
              DateFormat('dd-MM-yyyy').format(checkOutDate);
        } else {
          _checkOutController.clear();
        }
      });
    }
  }

  void _updateCheckOutDate() {
    if (checkInDate != null && durationInDays != null) {
      final checkOut = checkInDate!.add(Duration(days: durationInDays!));
      _checkOutController.text = DateFormat('dd-MM-yyyy').format(checkOut);
    } else {
      _checkOutController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rentOptions = getRentTypeOptions(selectedCategory);
    if (!rentOptions.contains(selectedRentType)) {
      selectedRentType = rentOptions.first;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['Housing', 'Apartment', 'Hotel', 'Villa']
                  .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  final options = getRentTypeOptions(value);
                  if (!options.contains(selectedRentType)) {
                    selectedRentType = options.first;
                  }
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedRentType,
              items: rentOptions
                  .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Rent Type'),
              onChanged: rentOptions.length == 1
                  ? null
                  : (value) {
                setState(() {
                  selectedRentType = value!;
                  if (durationRaw != null) {
                    durationInDays = selectedRentType == 'Monthly'
                        ? durationRaw! * 30
                        : durationRaw;
                  }
                  _updateCheckOutDate();
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _checkInController,
              readOnly: true,
              onTap: _selectCheckInDate,
              decoration: const InputDecoration(
                labelText: "Check-in",
                hintText: "Pilih tanggal",
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText:
                'Duration (${selectedRentType == 'Monthly' ? 'months' : 'days'})',
                hintText: selectedRentType == 'Monthly'
                    ? 'Masukkan jumlah bulan'
                    : 'Masukkan jumlah hari',
                suffixIcon: Icon(selectedRentType == 'Monthly'
                    ? Icons.calendar_today
                    : Icons.timer),
              ),
              onChanged: (value) {
                final parsed = int.tryParse(value);
                setState(() {
                  durationRaw = parsed;
                  durationInDays = parsed != null
                      ? (selectedRentType == 'Monthly' ? parsed * 30 : parsed)
                      : null;
                  _updateCheckOutDate();
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _checkOutController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Check-out",
                hintText: "Otomatis terisi",
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF005F21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  print('Category: $selectedCategory');
                  print('Rent Type: $selectedRentType');
                  print('Check-in: $checkInDate');
                  print('Duration: $durationInDays');
                  print('Check-out: ${_checkOutController.text}');
                },
                child: const Text(
                  'Search',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
