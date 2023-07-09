import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../constants/app_sizes.dart';
import '../../constants/text_styles.dart';
import '../dark_button.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String address = '1601 N Machias Rd\nLake Stevens, WA 98258';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Lake Stevens\nCommunity Park',
            style: kTextDark28.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          gapH12,
          Text(
            address,
            style: kTextDark20,
            textAlign: TextAlign.center,
          ),
          gapH24,
          DarkButton(
            function: () => MapsLauncher.launchQuery(address),
            title: 'Open Map',
          ),
        ],
      ),
    );
  }
}
