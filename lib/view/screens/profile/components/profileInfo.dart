import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    this.value,
    this.title,
  }) : super(key: key);
  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 5,
      width: SizeConfig.widthMultiplier * 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: SizeConfig.textMultiplier * 1.5))
        ],
      ),
    );
  }
}
