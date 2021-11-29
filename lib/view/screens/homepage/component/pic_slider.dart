import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Carousel extends StatelessWidget {
  Carousel({
    Key key,
    this.items,
    this.builderFunction,
    this.dividerIndent = 10,
    this.blurHash,
  }) : super(key: key);

  final List<dynamic> items, blurHash;
  final double dividerIndent;

  final Function(BuildContext context, dynamic item, dynamic blurHash)
      builderFunction;
  final ScrollController controller = ScrollController(keepScrollOffset: false);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          // physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
                indent: dividerIndent,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Widget item =
                builderFunction(context, items[index], blurHash[index]);
            if (index == 0) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(left: dividerIndent),
              );
            } else if (index == items.length - 1) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(right: dividerIndent),
              );
            }
            return item;
          }),
    );
  }
}
