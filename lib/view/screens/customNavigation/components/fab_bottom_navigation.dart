import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({ this.iconData});
  IconData iconData;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
     this.items,
    this.height: 60.0,
    this.iconSize: 24.0,
     this.backgroundColor,
     this.color,
     this.selectedColor,
     this.notchedShape,
     this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
      ),
    );
  }

  Widget _buildTabItem({
     FABBottomAppBarItem item,
     int index,
     ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            highlightColor: Colors.grey[200],
            onTap: () => onPressed(index),
            child: Icon(item.iconData, color: color, size: widget.iconSize),
          ),
        ),
      ),
    );
  }
}
