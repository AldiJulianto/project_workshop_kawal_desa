import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_workshop_kawal_desa/models/user_location.dart';

class GeolocatorService {
  final Geolocator _geolocator = Geolocator();

  Future<UserLocation> getCurrentLocation() async {
    try {
      var addressLine = '';
      final Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      final Coordinates coordinates =
      Coordinates(position.latitude, position.longitude);
      final addres =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);

      if (position.mocked) {
        addressLine = addres.first.addressLine + '#FakeLocation';
      } else {
        addressLine  = addres.first.addressLine;
      }

      UserLocation userLocation = UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        addressLine: addressLine,
      );
      return userLocation;
    } catch(e) {
      return null;
    }
  }
}