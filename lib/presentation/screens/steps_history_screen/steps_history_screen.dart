import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:steps_counter/generated/l10n.dart';

class StepsHistoryScreen extends ConsumerWidget {
  const StepsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stream provider to fetch steps history from Firestore
    final stepsStream = FirebaseFirestore.instance
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.steps_history),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stepsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text(S.current.empty_state));
          }

          final stepsData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: stepsData.length,
            itemBuilder: (context, index) {
              final stepEntry = stepsData[index];
              final stepCount = stepEntry['totalSteps'] as int;
              final name = stepEntry['userName'] as String;
              DateFormat formatter = DateFormat('yyyy-MM-dd h:mm a');

              final timestamp =
                  stepEntry['createdAt']?.toDate() ?? DateTime.now();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation:2 ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text('${S.current.steps_list}: $stepCount'),
                        Text('${S.current.date}: ${formatter.format(timestamp)}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
