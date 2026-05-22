import 'package:flutter/material.dart';
import 'package:mobileprogramming/pertemuan9/pages/profil_page.dart';
import 'package:intl/intl.dart';

class DatetimePage extends StatefulWidget {
  DatetimePage({super.key});

  @override
  State<DatetimePage> createState() => _DatetimePageState();
}

class _DatetimePageState extends State<DatetimePage> {
  final List<Widget> page = [ProfilePage(), DatetimePage()];

  TextEditingController timePicker = TextEditingController();
  TextEditingController datePicker = TextEditingController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertemuan 9"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //Time Picker
            TextField(
              controller: timePicker,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Pick current a Time',
                labelStyle: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onTap: () async {
                var time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    timePicker.text = time.format(context);
                  });
                }
              },
            ),
            
            SizedBox(height: 20),

            //Date Picker
            TextField(
              controller: datePicker,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Pick current a Date',
                labelStyle: TextStyle(fontSize: 16, color: Colors.blue),
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