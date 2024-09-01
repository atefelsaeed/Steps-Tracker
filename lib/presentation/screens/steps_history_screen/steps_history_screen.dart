import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/generated/l10n.dart';

class StepsHistoryScreen extends ConsumerWidget {
  const StepsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stream provider to fetch steps history from Firestore
    final stepsStream = FirebaseFirestore.instance
        .collection('steps')
        .orderBy('timestamp', descending: true)
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
              final stepCount = stepEntry['steps'] as int;
              final timestamp =
                  stepEntry['timestamp']?.toDate() ?? DateTime.now();

              return ListTile(
                title: Text('${S.current.steps_list}: $stepCount'),
                subtitle: Text('${S.current.date}: ${timestamp.toLocal()}'),

              );
            },
          );
        },
      ),
    );
  }
}
