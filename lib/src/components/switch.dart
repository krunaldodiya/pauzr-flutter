import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';

Widget getSwitch({
  List<String> items,
  String selected,
  Function onSelect,
  DefaultTheme theme,
}) {
  List<Widget> switchList = getList(items, selected, onSelect);

  return Container(
    padding: EdgeInsets.all(0.5),
    decoration: BoxDecoration(
      color: theme.segmentBar.backgroundColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: EdgeInsets.all(10.0),
    child: Row(
      children: switchList,
    ),
  );
}

List<Widget> getList(List<String> items, String selected, onSelect) {
  List<Widget> switchList = [];

  items.asMap().forEach((index, value) {
    var backgroundColor = value == selected ? Colors.transparent : Colors.white;

    var textColor = value == selected ? Colors.white : Colors.black;

    BorderRadius borderRadius;

    if (index == 0) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
      );
    } else if (index == items.length - 1) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      );
    } else {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(0.0),
        bottomLeft: Radius.circular(0.0),
      );
    }

    switchList.add(
      Expanded(
        child: GestureDetector(
          onTap: () => onSelect(index, value),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(0.5),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 18.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

  return switchList;
}
