import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  int selectedIndex;

  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  BottomNavBar(
      {Key key,
        this.selectedIndex = 0,
        this.showElevation = true,
        this.iconSize = 24,
        this.backgroundColor,
        @required this.items,
        @required this.onItemSelected}) {

    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
  }

  @override
  _BottomNavBarState createState() {
    return _BottomNavBarState(
        items: items,
        backgroundColor: backgroundColor,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

}

class _BottomNavBarState extends State<BottomNavBar> {
  final double iconSize;
  Color backgroundColor;
  List<BottomNavBarItem> items;
  ValueChanged<int> onItemSelected;

  @override
  void initState() {
    super.initState();
  }

  _BottomNavBarState(
      {@required this.items,
        this.backgroundColor,
        this.iconSize,
        @required this.onItemSelected});

  Widget _buildItem(BottomNavBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 130 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 270),
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),

      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inactiveColor == null
                          ? item.activeColor
                          : item.inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                style: TextStyle(
                    color: item.activeColor, fontWeight: FontWeight.bold),
                child: item.title,
              ) : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;
    return Container(
      color: Colors.transparent,
      // decoration: BoxDecoration(
      //     color: backgroundColor,
      //     boxShadow: [
      //       if(widget.showElevation)
      //         BoxShadow(color: Colors.black12, blurRadius: 2)
      //     ]
      // ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 0,bottom: 40),
          color: Colors.transparent,
            child: Container(
            width: double.minPositive,
            height: 56,
            padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                if(widget.showElevation)
                BoxShadow(color: Colors.black26, blurRadius: 12)
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () {
                    onItemSelected(index);
                    setState(() {
                      widget.selectedIndex = index;
                    });
                  },
                  child: _buildItem(item, widget.selectedIndex == index),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  BottomNavBarItem(
      {@required this.icon,
        @required this.title,
        this.activeColor = Colors.blue,
        this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}