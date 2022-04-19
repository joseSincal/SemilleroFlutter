import 'package:geolocator/geolocator.dart';

class LocationProvider {

  Future<Position> determinePosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
