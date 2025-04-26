import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  Position? _position;

  void saveCurrentLocation(Position position) {
    _position = position;
    notifyListeners();
  }

  Position? getCurrentLocation() => _position;
}
