import 'package:session_test/data/models/session_model.dart';
import 'package:session_test/data/repositories/session_repository.dart';

class GetSessions {
  final SessionRepository repository;

  GetSessions(this.repository);

  Future<List<Session>> call() {
    return repository.getSessions();
  }
}
