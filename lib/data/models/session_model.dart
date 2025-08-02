import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final DateTime date;
  final String customer;
  final double amount;

  const Session({
    required this.date,
    required this.customer,
    required this.amount,
  });

  @override
  List<Object> get props => [date, customer, amount];
}
