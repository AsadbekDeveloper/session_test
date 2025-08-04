import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<SessionBloc>().add(const LoadSessions());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
