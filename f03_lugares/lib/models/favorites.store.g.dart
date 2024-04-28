// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesModelX on _FavoritesModelX, Store {
  Computed<ObservableList<Place>>? _$getPlacesComputed;

  @override
  ObservableList<Place> get getPlaces => (_$getPlacesComputed ??=
          Computed<ObservableList<Place>>(() => super.getPlaces,
              name: '_FavoritesModelX.getPlaces'))
      .value;

  late final _$placesAtom =
      Atom(name: '_FavoritesModelX.places', context: context);

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

  late final _$_FavoritesModelXActionController =
      ActionController(name: '_FavoritesModelX', context: context);

  @override
  void add(Place place) {
    final _$actionInfo = _$_FavoritesModelXActionController.startAction(
        name: '_FavoritesModelX.add');
    try {
      return super.add(place);
    } finally {
      _$_FavoritesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Place place) {
    final _$actionInfo = _$_FavoritesModelXActionController.startAction(
        name: '_FavoritesModelX.remove');
    try {
      return super.remove(place);
    } finally {
      _$_FavoritesModelXActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool searchPlace(String placeId) {
    final _$actionInfo = _$_FavoritesModelXActionController.startAction(
        name: '_FavoritesModelX.searchPlace');
    try {
      return super.searchPlace(placeId);
    } finally {
      _$_FavoritesModelXActionController.endAction(_$actionInfo);
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
