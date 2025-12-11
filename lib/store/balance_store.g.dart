// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BalanceStore on _BalanceStore, Store {
  Computed<double>? _$balanceComputed;

  @override
  double get balance => (_$balanceComputed ??= Computed<double>(
    () => super.balance,
    name: '_BalanceStore.balance',
  )).value;

  @override
  String toString() {
    return '''
balance: ${balance}
    ''';
  }
}
