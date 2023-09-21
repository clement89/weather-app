import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  LocationService();

  Future<void> fetchLocation(
      {required Function(Position) onSuccess,
      required Function(FailureType, String?) onFailure}) async {
    final PermissionStatus permissionStatus =
        await Permission.location.request();

    if (permissionStatus.isGranted) {
      try {
        // Fetch current location
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Call success callback with the obtained position
        onSuccess(position);
      } catch (e) {
        // Handle any location-related errors
        onFailure(FailureType.locationError, e.toString());
      }
    } else {
      // Permission denied
      onFailure(FailureType.permissionDenied, 'Location permission denied');
    }
  }
}

// Enum to represent failure types
enum FailureType {
  permissionDenied,
  locationError,
}
