import 'package:flutter/material.dart';

class WeakWeatherRow extends StatelessWidget {
  final List<Widget> children;
  const WeakWeatherRow({Key? key, this.children = const[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2, color: Theme.of(context).primaryColorDark))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
            
          ),
        ),
      ),
    );
  }
}
