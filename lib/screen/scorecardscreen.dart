// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/inspection_provider.dart';
import '../widget/inputscore.dart';

class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  final TextEditingController _stationController = TextEditingController();
  final TextEditingController _trainController = TextEditingController();
  final TextEditingController _inspectorController = TextEditingController();
  DateTime? _selectedDate;

  List<String> coaches = List.generate(13, (i) => "C${i + 1}");
  List<String> sections = ['T1', 'T2', 'T3', 'T4', 'D1', 'D2', 'B1', 'B2'];
  List<String> platform = [
    "P-Cleanliness",
    "P-Urinals",
    "P-WaterBooth",
    "P-Dustbin",
    "P-CirculatingArea"
  ];

  Future<void> _submitForm() async {
    final provider = Provider.of<InspectionProvider>(context, listen: false);

    final data = {
      "station_name": _stationController.text.trim(),
      "train_no": _trainController.text.trim(),
      "inspection_date": _selectedDate?.toIso8601String() ?? '',
      "inspector": _inspectorController.text.trim(),
      "scores": provider.toJson(),
    };

    try {
      final response = await http.post(
        Uri.parse("https://httpbin.org/post"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Form submitted successfully!")),
        );
        print("Response: ${response.body}"); //printing the response
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clean Train Scorecard")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _stationController,
                    decoration:
                        const InputDecoration(labelText: "Station Name"),
                  ),
                  TextField(
                    controller: _trainController,
                    decoration:
                        const InputDecoration(labelText: "Train Number"),
                  ),
                  TextField(
                    controller: _inspectorController,
                    decoration:
                        const InputDecoration(labelText: "Inspector Name"),
                  ),
                  Row(
                    children: [
                      const Text("Date of Inspection: "),
                      Text(_selectedDate == null
                          ? "Select"
                          : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            initialDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _selectedDate = picked);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            ...coaches.map((coach) {
              return ExpansionTile(
                title: Text("Coach $coach"),
                children: sections
                    .map((sec) => ScoreInput(id: "$coach-$sec"))
                    .toList(),
              );
            }).toList(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Platform Parameters",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ...platform.map((id) => ScoreInput(id: id)).toList(),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.send_rounded),
              label: const Text("Submit"),
              onPressed: _submitForm,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
