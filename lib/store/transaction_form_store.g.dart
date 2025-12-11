// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionFormStore on _TransactionFormStore, Store {
  late final _$titleAtom = Atom(
    name: '_TransactionFormStore.title',
    context: context,
  );

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$sourceAtom = Atom(
    name: '_TransactionFormStore.source',
    context: context,
  );

  @override
  String get source {
    _$sourceAtom.reportRead();
    return super.source;
  }

  @override
  set source(String value) {
    _$sourceAtom.reportWrite(value, super.source, () {
      super.source = value;
    });
  }

  late final _$amountAtom = Atom(
    name: '_TransactionFormStore.amount',
    context: context,
  );

  @override
  double get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(double value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$imageUrlAtom = Atom(
    name: '_TransactionFormStore.imageUrl',
    context: context,
  );

  @override
  String get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  late final _$isIncomeAtom = Atom(
    name: '_TransactionFormStore.isIncome',
    context: context,
  );

  @override
  bool get isIncome {
    _$isIncomeAtom.reportRead();
    return super.isIncome;
  }

  @override
  set isIncome(bool value) {
    _$isIncomeAtom.reportWrite(value, super.isIncome, () {
      super.isIncome = value;
    });
  }

  late final _$_TransactionFormStoreActionController = ActionController(
    name: '_TransactionFormStore',
    context: context,
  );

  @override
  void updateTitle(String value) {
    final _$actionInfo = _$_TransactionFormStoreActionController.startAction(
      name: '_TransactionFormStore.updateTitle',
    );
    try {
      return super.updateTitle(value);
    } finally {
      _$_TransactionFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSource(String value) {
    final _$actionInfo = _$_TransactionFormStoreActionController.startAction(
      name: '_TransactionFormStore.updateSource',
    );
    try {
      return super.updateSource(value);
    } finally {
      _$_TransactionFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAmount(String value) {
    final _$actionInfo = _$_TransactionFormStoreActionController.startAction(
      name: '_TransactionFormStore.updateAmount',
    );
    try {
      return super.updateAmount(value);
    } finally {
      _$_TransactionFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateImageUrl(String value) {
    final _$actionInfo = _$_TransactionFormStoreActionController.startAction(
      name: '_TransactionFormStore.updateImageUrl',
    );
    try {
      return super.updateImageUrl(value);
    } finally {
      _$_TransactionFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateIsIncome(bool value) {
    final _$actionInfo = _$_TransactionFormStoreActionController.startAction(
      name: '_TransactionFormStore.updateIsIncome',
    );
    try {
      return super.updateIsIncome(value);
    } finally {
      _$_TransactionFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
source: ${source},
amount: ${amount},
imageUrl: ${imageUrl},
isIncome: ${isIncome}
    ''';
  }
}
