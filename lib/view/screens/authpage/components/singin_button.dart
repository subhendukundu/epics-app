import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    this.icondata,
    this.ontap,
    Key key,
  }) : super(key: key);
  final IconData icondata;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).accentColor.withOpacity(0.2),
      onTap: ontap,
      child: Container(
        width: SizeConfig.widthMultiplier * 43,
        height: SizeConfig.heightMultiplier * 8,
        child: Center(
          child: FaIcon(icondata, color: Theme.of(context).accentColor),
        ),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).accentColor.withOpacity(0.5)),
          // color: Theme.of(context).highlightColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
