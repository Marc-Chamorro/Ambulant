import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../login&singup/loginsingup_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = const Duration(seconds: 1);

    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context) {
            return LoginSignupScreen();
          }
        ), 
        (route) => false,
      );
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //''backgroundColor: ColorPrimary,
      
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        //padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        // decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/images/LogoSinFondoRECORTADO.png')
          // )
          //color: ColorPrimary,
        // ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [
              0, 
              0.45, 
              //0.90, 
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorSecond,
              ColorPrimary
            ],
          )
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 60),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Ambulant ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFFEFEFE),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage('assets/images/LogoSinFondoRECORTADO.png'),
                          width: 200.0,
                        ),
                      ],
                    ),
                  ),
                ]
              )
            )
          ],
        )
        // child: const Center (
        //   child: Image(
        //     image: AssetImage('assets/images/LogoSinFondoRECORTADO.png'),
        //     width: 200.0,
        //   ),
        // )
      ),
    );
  }
}