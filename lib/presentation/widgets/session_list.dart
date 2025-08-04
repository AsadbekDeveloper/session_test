import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:session_test/presentation/bloc/session_bloc.dart';
import 'package:session_test/data/models/session_model.dart';

class SessionList extends StatelessWidget {
  final Map<DateTime, List<Session>> groupedSessions;

  const SessionList({super.key, required this.groupedSessions});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final date = dates[index];
          final sessions = groupedSessions[date]!;
          final totalAmount = sessions.fold<double>(0, (sum, session) => sum + session.amount);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date:', style: Theme.of(context).textTheme.headlineSmall),
                    Text(
                      DateFormat('EEEE, MMMM d, y').format(date),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                shadowColor: Colors.grey.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sessions.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey.shade300),
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sessions[index].customer,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          sessions[index].amount.toStringAsFixed(0),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      totalAmount.toStringAsFixed(0),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
