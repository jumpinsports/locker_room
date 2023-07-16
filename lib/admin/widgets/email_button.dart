import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class EmailButton extends StatelessWidget {
  const EmailButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width * .80,
        decoration: const BoxDecoration(
          color: kMainDarkColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: [
            const Icon(Icons.email, size: 48, color: kMainAccentColor),
            Text('Email all', style: kTextLight20)
          ],
        ),
      ),
    );
  }
}