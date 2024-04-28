// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myCountries.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyCountriesModelX on _MyCountriesModelX, Store {
  Computed<List<Country>>? _$getCountriesComputed;

  @override
  List<Country> get getCountries => (_$getCountriesComputed ??=
          Computed<List<Country>>(() => super.getCountries,
              name: '_MyCountriesModelX.getCountries'))
      .value;

  late final _$countriesAtom =
      Atom(name: '_MyCountriesModelX.countries', context: context);

  @override
  ObservableList<Country> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(ObservableList<Country> value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
    });
  }

  late final _$_MyCountriesModelXActionController =
      ActionController(name: '_MyCountriesModelX', context: context);

  @override
  void add(Country country) {
    final _$actionInfo = _$_MyCountriesModelXActionController.startAction(
        name: '_MyCountriesModelX.add');
    try {
      return super.add(country);
    } finally {
      _$_MyCountriesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Country country) {
    final _$actionInfo = _$_MyCountriesModelXActionController.startAction(
        name: '_MyCountriesModelX.remove');
    try {
      return super.remove(country);
    } finally {
      _$_MyCountriesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countries: ${countries},
getCountries: ${getCountries}
    ''';
  }
}
