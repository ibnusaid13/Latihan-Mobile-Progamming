import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimePage extends StatefulWidget {
  const DatetimePage({super.key});

  @override
  State<DatetimePage> createState() => _DatetimePageState();
}

class _DatetimePageState extends State<DatetimePage> {
  // Variabel list page dan currentPage dihapus karena tidak diperlukan di sini
  // (Sudah diatur oleh MyApp9)

  TextEditingController timePicker = TextEditingController();
  TextEditingController datePicker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PERBAIKAN: AppBar dihapus agar tidak bertumpuk dengan AppBar di MyApp9
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Time Picker
            TextField(
              controller: timePicker,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Pick current a Time',
                labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () async {
                var time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    // ignore: use_build_context_synchronously
                    timePicker.text = time.format(context);
                  });
                }
              },
            ),
            
            const SizedBox(height: 20),

            // Date Picker
            TextField(
              controller: datePicker,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Pick current a Date',
                labelStyle: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () async {
                DateTime? datetime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                );
                if (datetime != null) {
                  String formattedDate = DateFormat(
                    'yyyy-MM-dd',
                  ).format(datetime);

                  setState(() {
                    datePicker.text = formattedDate;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}