import 'package:session_test/data/models/session_model.dart';

class SessionRepository {
  Future<List<Session>> getSessions() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Session(date: DateTime(2024, 7, 20), customer: 'Alice', amount: 100.0),
      Session(date: DateTime(2024, 7, 20), customer: 'Bob', amount: 150.0),
      Session(date: DateTime(2024, 7, 21), customer: 'Charlie', amount: 200.0),
      Session(date: DateTime(2024, 7, 21), customer: 'David', amount: 50.0),
      Session(date: DateTime(2024, 7, 22), customer: 'Eve', amount: 300.0),
    ];
  }
}
