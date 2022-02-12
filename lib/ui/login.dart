import 'dart:async';
import 'package:flutter/material.dart';
import 'package:key_guardmanager/key_guardmanager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:accounts/ui/home.dart';
import 'package:accounts/library/bioMSinsor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget  {


  @override
  _Login createState()  => new _Login();

}

class _Login extends State<Login>  {


  @override
  void initState() {
    super.initState();
  }

  BioMetric bb = new BioMetric();
  String massige = "";


  Future<void> initPlatformState() async {
    String authCheck;
    try {
      authCheck = await KeyGuardmanager.authStatus;
      if(authCheck == "true"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListView1()),
        );
      }
    } on PlatformException {
      authCheck = 'Failed to get platform offline Auth.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {


    return Directionality(
        textDirection: TextDirection.rtl,

        child: Scaffold(
            backgroundColor:Color(0xFF2f3542),

            appBar: AppBar(

              title: Text("حساباتي",
                style:TextStyle(
                  color: Color(0xFFeccc68),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ) ,),

              backgroundColor: Color(0xFF2f3542),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.face), onPressed: showMassage,
                ),
              ],
            ),
            body: Center(

              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    //   padding: EdgeInsets.all(5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,,
                        children: <Widget>[
                           Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child:
                                  IconButton(onPressed: initPlatformState ,
                                      color: Color(0xFFeccc68),
                                      icon: Icon(Icons.apps)),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child:
                            new Text("تسجيل دخول",

                              style:TextStyle(
                                color: Color(0xFFeccc68),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ) ,
                          ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child:
                            IconButton(onPressed: checkCheck ,
                              color: Color(0xFFeccc68),
                              icon: Icon(Icons.fingerprint),),
                          ),
                        ]
                    ),

                    Container(
                        padding: EdgeInsets.only(top: 50),
                        child: new Text("$massige",
                          style: TextStyle(
                            fontSize: 17,
                            background: Paint(),
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                  ],
                ),
              ) ,

            )



        )


    );


  }






  ///check IF there its Biometrics in device

  Future<void> checkCheck() async {

    bool x  =  await bb.authenticate();
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics == true) {
      if (x == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListView1()),
        );

      } else {

      }

    } else if (canCheckBiometrics == false) {

  //    nativePass();

      setState(() {
        massige = "للأسف هذا الهاتف لا يملك اي نوع من انواع البصمة";
      });

    }


  }







  ///
  Future<void> showMassage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return
          AlertDialog(
            contentPadding: const EdgeInsets.all(5.7),
            shape:RoundedRectangleBorder
              ( side: BorderSide(color:Colors.black,width: 1.5),
                borderRadius: BorderRadius.all( Radius.circular(10.5))
            ),

            content: Container(
              padding: EdgeInsets.all(2),
              child:
              new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    new Text("التطبيق مفتوح المصدر"
                        "\tللدراسة و التطوير",
                      textAlign: TextAlign.center,
                    ),


                    FlatButton(onPressed: _goToUrl, child: Text("myApp/Github.com")
                      ,),

                    new FlatButton(
                        color: Colors.redAccent,
                        child: const Text('خروج من الرسالة'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),

                  ]
              ),
            ),
          );

      },
    );
  }


  _goToUrl() async {

    if (await canLaunch('https://github.com/tabarakMohammed/accounts')) {
      await launch('https://github.com/tabarakMohammed/accounts');
    } else {
      throw 'حدث خطأ ما، لا نستطيع الوصول للموقع ';
    }
  }


}


