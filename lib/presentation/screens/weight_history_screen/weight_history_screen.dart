import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_counter/data/models/user_model.dart';
import 'package:steps_counter/generated/l10n.dart';

class WeightEntriesScreen extends StatelessWidget {
  const WeightEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.weight_history)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text(S.current.empty_state));
          }

          final docs = snapshot.data!.docs;
          DateFormat formatter = DateFormat('yyyy-MM-dd h:mm a');

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              // Convert the document snapshot to a UserModel
              final userModel = UserModel.fromMap(
                docs[index].data() as Map<String, dynamic>,
                docs[index].id,
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userModel.name),
                        Text(
                          '${S.current.weight}: ${userModel.weight} ${S.current.kg}',
                        ),
                        Text(
                            '${S.current.date}: ${formatter.format(userModel.createdAt ?? DateTime.now())}'),
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
