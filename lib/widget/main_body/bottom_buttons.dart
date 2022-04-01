import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;

class BottomButtons extends StatefulWidget {
  final Function() notifyParent;
  BottomButtons({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _BottomButtons createState() => _BottomButtons();
}

class _BottomButtons extends State<BottomButtons> {

  @override
  Widget build(BuildContext context) {
  return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              //border: Border.all(color: Colors.blueAccent),
              border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  constant.window = "home_screen";
                });
                widget.notifyParent();
              },
              child: Icon(
                Icons.home,
                // color: Colors.black,
                color: _selectedColorIcon("home_screen"),
                size: 24,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  constant.window = "favorite_screen";
                });
                widget.notifyParent();
              },
              child: Icon(
                Icons.favorite_border,
                // color: Colors.black,
                color: _selectedColorIcon("favorite_screen"),
                size: 24,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  constant.window = "scan_screen";
                });
                widget.notifyParent();
              },
              child: Icon(
                Icons.qr_code_scanner,
                // color: Colors.black,
                color: _selectedColorIcon("scan_screen"),
                size: 24,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  constant.window = "map_screen";
                });
                widget.notifyParent();
              },
              child: Icon(
                Icons.room,
                // color: Colors.black,
                color: _selectedColorIcon("map_screen"),
                size: 24,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
            ),
            child: InkWell(
              onTap: () async {
                setState(() {
                  constant.window = "settings_screen";
                });
                widget.notifyParent();
              },
              child: Icon(
                Icons.settings,
                // color: Colors.black,
                color: _selectedColorIcon("settings_screen"),
                size: 24,
              ),
            ),
          )
        ]);
  }

  Color _selectedColorIcon(String finestra) {
    if (constant.window == finestra) {
      // Color c = constant.ColorPrimary;
      return constant.ColorPrimary;
    } else {
      // Color c = Colors.
      return Colors.black;
    }
  }
}