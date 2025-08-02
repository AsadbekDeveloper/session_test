import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_test/data/repositories/session_repository.dart';
import 'package:session_test/domain/usecases/get_sessions.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';
import 'package:session_test/presentation/screens/session_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session App',
      debugShowCheckedModeBanner: false,

      home: BlocProvider(
        create: (context) =>
            SessionBloc(GetSessions(SessionRepository()))..add(const LoadSessions()),
        child: const SessionScreen(),
      ),
    );
  }
}
