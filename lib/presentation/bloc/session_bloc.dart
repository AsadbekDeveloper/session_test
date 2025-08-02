import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:session_test/data/models/session_model.dart';
import 'package:session_test/domain/usecases/get_sessions.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetSessions getSessions;

  SessionBloc(this.getSessions) : super(SessionInitial()) {
    on<LoadSessions>(_onLoadSessions);
    on<SearchSession>(_onSearchSession, transformer: (events, mapper) {
      return events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper);
    });
  }

  void _onLoadSessions(LoadSessions event, Emitter<SessionState> emit) async {
    if (!event.isRefresh) {
      emit(SessionLoading());
    }
    try {
      final sessions = await getSessions();
      final groupedSessions = _groupSessionsByDate(sessions);
      emit(SessionLoaded(allSessions: sessions, groupedSessions: groupedSessions));
    } catch (e) {
      emit(SessionError(e.toString()));
    }
  }

  void _onSearchSession(SearchSession event, Emitter<SessionState> emit) {
    if (state is SessionLoaded) {
      final currentState = state as SessionLoaded;
      final searchTerm = event.searchTerm.toLowerCase();
      final filteredSessions = currentState.allSessions.where((session) {
        return session.customer.toLowerCase().contains(searchTerm);
      }).toList();
      final groupedSessions = _groupSessionsByDate(filteredSessions);
      emit(currentState.copyWith(
        groupedSessions: groupedSessions,
        searchTerm: event.searchTerm,
      ));
    }
  }

  Map<DateTime, List<Session>> _groupSessionsByDate(List<Session> sessions) {
    final Map<DateTime, List<Session>> grouped = {};
    for (var session in sessions) {
      final date = DateTime(session.date.year, session.date.month, session.date.day);
      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(session);
    }
    return grouped;
  }
}
