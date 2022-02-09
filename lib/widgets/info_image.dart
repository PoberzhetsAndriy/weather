import 'package:flutter/material.dart';

class InfoImage extends StatelessWidget {
  final String info;
  static const Map images = {
    'Humidity': 'assets/images/Humidity.png',
    'Visibility': 'assets/images/Visibility.png',
    'Preasure': 'assets/images/Preasure.png',
    'N': 'assets/images/N.png',
    'E': 'assets/images/E.png',
    'W': 'assets/images/W.png',
    'S': 'assets/images/S.png',
    'NE': 'assets/images/NE.png',
    'NW': 'assets/images/NW.png',
    'WS': 'assets/images/WS.png',
    'ES': 'assets/images/ES.png',
  };
  const InfoImage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      images[info] as String,
      scale: 2,
    );
  }
}
