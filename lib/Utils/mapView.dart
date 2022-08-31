import 'package:dustbin_app/Utils/cons.dart';
import 'package:url_launcher/url_launcher.dart';

void mapView(String lat, String lan) async {

  final url = 'https://www.google.com/maps/dir/?api=1&origin=${Constance.currentLatitude},${Constance.currentLongitude}&destination=$lat,$lan';
//  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lan';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}