import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// double calculateDistance(
//     {required num fromLat, required toLat, required fromLng, required toLng}) {
//   return (Geolocator.distanceBetween(
//             fromLat.toDouble(),
//             fromLng.toDouble(),
//             toLat.toDouble(),
//             toLng.toDouble(),
//           ) /
//           1000)
//       .floorToDouble();
// }

double calculateDistance({
  required num fromLat,
  required num fromLng,
  required num toLat,
  required num toLng,
}) {
  return (Geolocator.distanceBetween(
    fromLat.toDouble(),
    fromLng.toDouble(),
    toLat.toDouble(),
    toLng.toDouble(),
  ) / 1000)
      .floorToDouble(); // distance in KM, rounded down
}


void navigationHelper(double lat, double lng) async {
  var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  if (await launchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch ${uri.toString()}';
  }
}
