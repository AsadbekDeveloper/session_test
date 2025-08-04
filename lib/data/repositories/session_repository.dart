import 'package:session_test/data/models/session_model.dart';

class SessionRepository {
  Future<List<Session>> getSessions() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Session(date: DateTime(2024, 7, 20), customer: 'Customer A', amount: 100.0),
      Session(date: DateTime(2024, 7, 20), customer: 'Customer B', amount: 150.0),
      Session(date: DateTime(2024, 7, 20), customer: 'Customer C', amount: 75.0),
      Session(date: DateTime(2024, 7, 21), customer: 'Customer D', amount: 200.0),
      Session(date: DateTime(2024, 7, 21), customer: 'Customer E', amount: 50.0),
      Session(date: DateTime(2024, 7, 21), customer: 'Customer F', amount: 90.0),
      Session(date: DateTime(2024, 7, 25), customer: 'Customer N', amount: 155.0),
      Session(date: DateTime(2024, 7, 25), customer: 'Customer O', amount: 190.0),
      Session(date: DateTime(2024, 7, 26), customer: 'Customer P', amount: 220.0),
      Session(date: DateTime(2024, 7, 26), customer: 'Customer Q', amount: 80.0),
      Session(date: DateTime(2024, 7, 27), customer: 'Customer R', amount: 170.0),
      Session(date: DateTime(2024, 7, 27), customer: 'Customer S', amount: 140.0),
      Session(date: DateTime(2024, 7, 27), customer: 'Customer T', amount: 200.0),
    ];
  }
}
