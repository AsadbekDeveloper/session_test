part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class LoadSessions extends SessionEvent {
  final bool isRefresh;

  const LoadSessions({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class SearchSession extends SessionEvent {
  final String searchTerm;

  const SearchSession(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
