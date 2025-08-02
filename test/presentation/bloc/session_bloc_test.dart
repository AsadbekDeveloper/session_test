import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:session_test/data/models/session_model.dart';
import 'package:session_test/domain/usecases/get_sessions.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';

import '../../mocks.mocks.dart';

void main() {
  late MockSessionRepository mockSessionRepository;
  late GetSessions getSessions;
  late SessionBloc sessionBloc;

  setUp(() {
    mockSessionRepository = MockSessionRepository();
    getSessions = GetSessions(mockSessionRepository);
    sessionBloc = SessionBloc(getSessions);
  });

  final tSessions = [
    Session(date: DateTime(2024, 7, 20), customer: 'Alice', amount: 100.0),
    Session(date: DateTime(2024, 7, 21), customer: 'Bob', amount: 150.0),
  ];

  final tGroupedSessions = {
    DateTime(2024, 7, 20): [Session(date: DateTime(2024, 7, 20), customer: 'Alice', amount: 100.0)],
    DateTime(2024, 7, 21): [Session(date: DateTime(2024, 7, 21), customer: 'Bob', amount: 150.0)],
  };

  test('initial state should be SessionInitial', () {
    expect(sessionBloc.state, equals(SessionInitial()));
  });

  blocTest<SessionBloc, SessionState>(
    'should emit [SessionLoading, SessionLoaded] when data is gotten successfully',
    build: () {
      when(mockSessionRepository.getSessions()).thenAnswer((_) async => tSessions);
      return sessionBloc;
    },
    act: (bloc) => bloc.add(const LoadSessions()),
    expect: () => [
      SessionLoading(),
      SessionLoaded(allSessions: tSessions, groupedSessions: tGroupedSessions),
    ],
  );

  blocTest<SessionBloc, SessionState>(
    'should emit [SessionLoading, SessionError] when getting data fails',
    build: () {
      when(mockSessionRepository.getSessions()).thenThrow(Exception('Failed to fetch sessions'));
      return sessionBloc;
    },
    act: (bloc) => bloc.add(const LoadSessions()),
    expect: () => [SessionLoading(), const SessionError('Exception: Failed to fetch sessions')],
  );

  blocTest<SessionBloc, SessionState>(
    'should filter sessions based on search term',
    build: () {
      when(mockSessionRepository.getSessions()).thenAnswer((_) async => tSessions);
      return sessionBloc;
    },
    act: (bloc) async {
      bloc.add(const LoadSessions());
      await Future.delayed(const Duration(milliseconds: 100));
      bloc.add(const SearchSession('Alice'));
    },
    skip: 2,
    expect: () => [
      isA<SessionLoaded>().having((s) => s.groupedSessions, 'groupedSessions', {
        DateTime(2024, 7, 20): [
          Session(date: DateTime(2024, 7, 20), customer: 'Alice', amount: 100.0),
        ],
      }),
    ],
  );
}
