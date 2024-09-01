// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pedometer/pedometer.dart';
//
// final stepProvider = StreamProvider<int>((ref) {
//   return Pedometer.stepCountStream.map((event) => event.steps);
// });
//
// class StepCounter extends ConsumerWidget {
//   const StepCounter({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stepCount = ref.watch(stepProvider);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Steps Tracker')),
//       body: stepCount.when(
//         data: (steps) {
//           return Center(child: Text('Steps: $steps'));
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, s) => Text('Error: $e'),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/domain/steps_service/steps_service.dart';
import 'package:steps_counter/generated/l10n.dart';

class StepCounterScreen extends ConsumerWidget {
  const StepCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the step counter provider for changes
    final stepCount = ref.watch(stepCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.steps_tracker,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.current.current_steps,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                stepCount.toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
