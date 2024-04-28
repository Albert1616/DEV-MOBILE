import "package:f03_lugares/models/place.dart";
import "package:mobx/mobx.dart";

part 'favorites.store.g.dart';

class FavoritesModelX = _FavoritesModelX with _$FavoritesModelX;

abstract class _FavoritesModelX with Store {
  @observable
  ObservableList<Place> places = ObservableList<Place>();

  @computed
  ObservableList<Place> get getPlaces => this.places;

  @action
  void add(Place place) {
    this.places.add(place);
  }

  @action
  void remove(Place place) {
    this.places.remove(place);
  }

  @action
  bool searchPlace(String placeId) {
    for (Place place in this.places) {
      if (place.id == placeId) {
        return true;
      }
    }
    return false;
  }
}
