// 1. Créer les widgets pour l'interface utilisateur
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (amount) => BlocProvider.of<ConverterBloc>(context)
              .add(AmountChanged(double.parse(amount))),
        ),
        DropdownButton<String>(
          value: 'USD',
          onChanged: (currency) => BlocProvider.of<ConverterBloc>(context)
              .add(CurrencyChanged(currency!)),
          items: ['USD', 'EUR', 'JPY']
              .map((currency) => DropdownMenuItem(
            value: currency,
            child: Text(currency),
          ))
              .toList(),
        ),
      ],
    );
  }
}
abstract class ConverterEvent {}

class AmountChanged extends ConverterEvent {
  final double amount;

  AmountChanged(this.amount);
}

class CurrencyChanged extends ConverterEvent {
  final String currency;

  CurrencyChanged(this.currency);
}
// 3. Créer le bloc pour gérer la logique métier de l'application
class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(ConverterState(0.0, 'USD'));

  @override
  Stream<ConverterState> mapEventToState(ConverterEvent event) async* {
    if (event is AmountChanged) {
      yield ConverterState(
          event.amount, state.toCurrency);
    } else if (event is CurrencyChanged) {
      yield ConverterState(
          state.amount, event.currency);
    }
  }
}

class ConverterState {
  final double amount;
  final String toCurrency;

  ConverterState(this.amount, this.toCurrency);
}