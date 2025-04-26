import 'package:url_launcher/url_launcher.dart';

callHelper(String phoneNumber) async {
  if (!await launchUrl(Uri.parse("tel:${phoneNumber}"))) {
    throw Exception('Could not launch');
  }
}
