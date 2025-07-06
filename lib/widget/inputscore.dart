import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/inspection_provider.dart';

class ScoreInput extends StatelessWidget {
  final String id;

  const ScoreInput({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InspectionProvider>(context);
    final item = provider.items[id];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Score: "),
                DropdownButton<int>(
                  value: item?.score == 0 ? null : item?.score,
                  hint: const Text("Select"),
                  items: List.generate(10, (index) => index + 1)
                      .map((val) => DropdownMenuItem(
                            value: val,
                            child: Text(val.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      provider.setScore(id, value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              decoration:
                  const InputDecoration(labelText: "Remarks (optional)"),
              onChanged: (val) => provider.setRemarks(id, val),
            ),
          ],
        ),
      ),
    );
  }
}
