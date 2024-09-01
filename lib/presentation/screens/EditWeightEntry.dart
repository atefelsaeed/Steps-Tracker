import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditWeightEntry extends StatelessWidget {
  final String docId;
  final TextEditingController weightController;

  EditWeightEntry({super.key, required this.docId, required double weight})
      : weightController = TextEditingController(text: weight.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Weight Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                double weight = double.parse(weightController.text);

                await FirebaseFirestore.instance
                    .collection('weights')
                    .doc(docId)
                    .update({
                  'weight': weight,
                });

                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('weights')
                    .doc(docId)
                    .delete();

                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
