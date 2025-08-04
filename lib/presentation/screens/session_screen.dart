import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';
import 'package:session_test/presentation/widgets/error_view.dart';
import 'package:session_test/presentation/widgets/search_field.dart';
import 'package:session_test/presentation/widgets/session_list.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<SessionBloc>().add(SearchSession(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Column(
        children: [
          SearchField(controller: _searchController),
          Expanded(
            child: BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SessionError) {
                  return ErrorView(message: state.message);
                } else if (state is SessionLoaded) {
                  return SessionList(groupedSessions: state.groupedSessions);
                }
                return Center(
                  child: Text('Pull to refresh.', style: Theme.of(context).textTheme.headlineSmall),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
