import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;

class SettingsButtons extends StatefulWidget {
  final Function() notifyParent;
  SettingsButtons({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _SettingsButtons createState() => _SettingsButtons();
}

class _SettingsButtons extends State<SettingsButtons> {

  //widget.notifyParent();
  Color seleccionat = Color(0xFFFFB300);
  Color noseleccionat = Color(0xF1FFC400);

  @override
  Widget build(BuildContext context) {

  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.07,
    decoration: BoxDecoration(
      color: Color(0xFFEEEEEE),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: TextButton(
            onPressed: () {
              print('Button pressed ...');
              constant.settingsScreenChoosenType = "user";
              widget.notifyParent();
            },
            child: Text(
              'User',
              style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
            ),
            // text: 'Button',
            style: ButtonStyle(
              // width: 130,
              // height: 40,
              backgroundColor: _seleccionarColorUser(),
              
              // borderSide: BorderSide(
              //   color: Colors.transparent,
              // ),
              // borderRadius: 0,

              // buttonS: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.transparent)
                  )
                // )
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: TextButton(
            onPressed: () {
              if (constant.userHasShop) {
                print('Button pressed ...');
                constant.settingsScreenChoosenType = "local";
                widget.notifyParent();
              }
            },
            child: Text(
              'Local',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: _seleccionarColorLocal(),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(color: Colors.transparent)
                )
              ),
            ),
          ),
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.5,
        //   height: 100,
        //   decoration: BoxDecoration(
        //     color: Color(0xF1F2B91C),
        //   ),
        //   child: FFButtonWidget(
        //     onPressed: () {
        //       print('Button pressed ...');
        //     },
        //     text: 'Button',
        //     options: FFButtonOptions(
        //       width: 130,
        //       height: 40,
        //       color: Color(0xFFF6CB55),
        //       textStyle:
        //           FlutterFlowTheme.of(context).subtitle2.override(
        //                 fontFamily: 'Poppins',
        //                 color: Colors.white,
        //               ),
        //       borderSide: BorderSide(
        //         color: Colors.transparent,
        //       ),
        //       borderRadius: 0,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
  }

  _seleccionarColorUser() {
    if (constant.settingsScreenChoosenType == "user") {
      return MaterialStateProperty.all<Color>(seleccionat);
    }
    return MaterialStateProperty.all<Color>(noseleccionat);
  }

  _seleccionarColorLocal() {
    if (constant.settingsScreenChoosenType == "local") {
      return MaterialStateProperty.all<Color>(seleccionat);
    }
    return MaterialStateProperty.all<Color>(noseleccionat);
  }
}