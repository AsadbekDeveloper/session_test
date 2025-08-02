import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by customer name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SessionError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message, textAlign: TextAlign.center),
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
                } else if (state is SessionLoaded) {
                  final groupedSessions = state.groupedSessions;
                  final dates = groupedSessions.keys.toList();

                  if (dates.isEmpty) {
                    return const Center(child: Text('No sessions found.'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<SessionBloc>().add(const LoadSessions(isRefresh: true));
                    },
                    child: ListView.builder(
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        final date = dates[index];
                        final sessions = groupedSessions[date]!;
                        final totalAmount = sessions.fold<double>(
                          0,
                          (sum, session) => sum + session.amount,
                        );

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat.yMMMd().format(date),
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    Text(
                                      'Total: \$${totalAmount.toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ...sessions.map(
                                (session) => ListTile(
                                  title: Text(session.customer),
                                  trailing: Text('\$${session.amount.toStringAsFixed(2)}'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(child: Text('Pull to refresh.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
