import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/widgets/progress.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final bool isLoading;
  final Gradient gradient;

  AuthButton({
    this.onTap,
    this.label,
    this.gradient,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: SizeConfig.widthMultiplier * 90,
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: isLoading == false || isLoading == null
            ? Text(label,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600))
            : circularProgress(Colors.white),
      ),
    );
  }
}
