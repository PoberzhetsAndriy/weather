import 'package:flutter/material.dart';










class InfoImage extends StatelessWidget {
  final String info;
  static const Map images = {
    'Humidity': 'assets/images/Humidity.png',
    'Visibility': 'assets/images/Visibility.png',
    'Preasure': 'assets/images/Preasure.png',
    'ENE': 'assets/images/ENE.png',
    'ESE': 'assets/images/ESE.png',
    'N': 'assets/images/N.png',
    'NE': 'assets/images/NE.png',
    'NNE': 'assets/images/NNE.png',
    'NNW': 'assets/images/NNW.png',
    'E': 'assets/images/E.png',
    'W': 'assets/images/W.png',
    'WNW': 'assets/images/WNW.png',
    'WSW': 'assets/images/WSW.png',
    'SW': 'assets/images/SW.png',
    'SSW': 'assets/images/SSW.png',
    'S': 'assets/images/S.png',
    'SE': 'assets/images/SE.png',
    'SSE': 'assets/images/SSE.png',
    'NW': 'assets/images/NW.png',
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
