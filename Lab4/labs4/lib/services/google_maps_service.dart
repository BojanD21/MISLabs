import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void _navigateToLocation(LatLng destination) async {
  final Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final Uri googleMapsUri = Uri.parse(
    'https://www.google.com/maps/dir/?api=1&origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving');
  if (await canLaunchUrl(googleMapsUri)) {
  if (await canLaunch(googleMapsUri.toString())) {
    await launch(googleMapsUri.toString());
  }
}
}
