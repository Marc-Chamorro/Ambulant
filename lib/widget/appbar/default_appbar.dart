import 'package:flutter/material.dart';

class DefaultAppBar {
  Appbar() {
    return AppBar(
      backgroundColor: Color(0xFFFFB300),
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 10),
        child: Text(
          'Ambulant',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [],
      centerTitle: false,
      elevation: 0,
    );
  }
}