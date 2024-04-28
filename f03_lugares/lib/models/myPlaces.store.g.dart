// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myPlaces.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyPlacesModelX on _MyPlacesModelX, Store {
  Computed<List<Place>>? _$getPlacesComputed;

  @override
  List<Place> get getPlaces =>
      (_$getPlacesComputed ??= Computed<List<Place>>(() => super.getPlaces,
              name: '_MyPlacesModelX.getPlaces'))
          .value;

  late final _$placesAtom =
      Atom(name: '_MyPlacesModelX.places', context: context);

  @override
  ObservableList<Place> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableList<Place> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  late final _$_MyPlacesModelXActionController =
      ActionController(name: '_MyPlacesModelX', context: context);

  @override
  void add(Place place) {
    final _$actionInfo = _$_MyPlacesModelXActionController.startAction(
        name: '_MyPlacesModelX.add');
    try {
      return super.add(place);
    } finally {
      _$_MyPlacesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Place place) {
    final _$actionInfo = _$_MyPlacesModelXActionController.startAction(
        name: '_MyPlacesModelX.remove');
    try {
      return super.remove(place);
    } finally {
      _$_MyPlacesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
places: ${places},
getPlaces: ${getPlaces}
    ''';
  }
}
