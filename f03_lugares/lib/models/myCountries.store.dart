import "package:f03_lugares/models/country.dart";
import "package:flutter/material.dart";
import "package:mobx/mobx.dart";

part "myCountries.store.g.dart";

class MyCountriesModelX = _MyCountriesModelX with _$MyCountriesModelX;

abstract class _MyCountriesModelX with Store {
  @observable
  ObservableList<Country> countries = ObservableList<Country>.of([
    Country(
      id: 'c1',
      title: 'Estados Unidos',
      color: Colors.purple,
    ),
    Country(
      id: 'c2',
      title: 'Canada',
      color: Colors.red,
    ),
    Country(
      id: 'c3',
      title: 'Suiça',
      color: Colors.orange,
    ),
    Country(
      id: 'c4',
      title: 'Chile',
      color: Colors.amber,
    ),
    Country(
      id: 'c5',
      title: 'Espanha',
      color: Colors.amber,
    ),
    Country(
      id: 'c7',
      title: 'Peru',
      color: Colors.lightBlue,
    ),
    Country(
      id: 'c8',
      title: 'Brasil',
      color: Colors.lightGreen,
    ),
    Country(
      id: 'c10',
      title: 'Egito',
      color: Colors.teal,
    ),
  ]);

  @computed
  List<Country> get getCountries => countries;

  @action
  void add(Country country) {
    this.countries.add(country);
  }

  @action
  void remove(Country country) {
    this.countries.remove(country);
  }
}
