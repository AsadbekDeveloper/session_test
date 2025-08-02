part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionLoaded extends SessionState {
  final List<Session> allSessions;
  final Map<DateTime, List<Session>> groupedSessions;
  final String searchTerm;

  const SessionLoaded({
    required this.allSessions,
    required this.groupedSessions,
    this.searchTerm = '',
  });

  @override
  List<Object> get props => [allSessions, groupedSessions, searchTerm];

  SessionLoaded copyWith({
    List<Session>? allSessions,
    Map<DateTime, List<Session>>? groupedSessions,
    String? searchTerm,
  }) {
    return SessionLoaded(
      allSessions: allSessions ?? this.allSessions,
      groupedSessions: groupedSessions ?? this.groupedSessions,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class SessionError extends SessionState {
  final String message;

  const SessionError(this.message);

  @override
  List<Object> get props => [message];
}
