
import 'dart:io';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:key_guardmanager/key_guardmanager.dart';

class BioMetric {




  Future<bool> authenticate() async {


    final LocalAuthentication auth = new LocalAuthentication();

    bool authenticated = false;
    bool ay = false;

    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();


    if (Platform.isAndroid) {

   //   print(availableBiometrics.toString());
      String authCheck;
      try {
        authCheck = await KeyGuardmanager.authStatus;
        if(authCheck == "true"){
          ay = true;

        }
      } on PlatformException {
        authCheck = 'Failed to get platform offline Auth.';
      }


/**
     package issue with android version
    because of android mainActivity flutter last version upgrade
    android embedding
      switch (availableBiometrics.toString()) {

      ///when face
        case '[BiometricType.face]' :
          {

            ///  debugPrint("worked!! face ");

              try {
                authenticated = await auth.authenticate(

                    localizedReason: 'أستخدم بصمة الوجه',
                    androidAuthStrings: AndroidAuthMessages(
                      biometricHint: "متحسس البصمة",
                      biometricNotRecognized:  "أدخال غير صحيح، لم يتم تميز البصمة ",
                      biometricRequiredTitle: "بصمتك مطلوبة !",
                      biometricSuccess:  "تم بنجاح",
                      signInTitle: "بصمة الوجه",
                      cancelButton: 'الغاء',
                      goToSettingsButton: 'أعدادات',
                      goToSettingsDescription: 'أضبط بصمتك',
                    ),
                    useErrorDialogs: false,
                    stickyAuth: true);
              }

              on PlatformException catch (e) {
                print( "error :" + e.message.toString());
              }


              if (authenticated) {
                ay = true;
              }

            break;
          }

      /// when finger
        case '[BiometricType.fingerprint]' :
          {

            ///  debugPrint("worked!! finger ");
            try {
              authenticated = await auth.authenticate(

                  localizedReason: 'أستخدم بصمة الأصبع',
                  androidAuthStrings: AndroidAuthMessages(
                    biometricHint: "متحسس البصمة",
                    biometricNotRecognized: "أدخال غير صحيح، لم يتم تميز البصمة ",
                    biometricRequiredTitle: "بصمتك مطلوبة !",
                    biometricSuccess: "تم بنجاح",
                    signInTitle: "بصمة الأصبع",
                    cancelButton: 'الغاء',

                    goToSettingsButton: 'أعدادات',
                    goToSettingsDescription: 'أضبط بصمتك',
                  ),
                  useErrorDialogs: false,
                  stickyAuth: true);


            }

            on PlatformException catch (e) {

              print( "print finger" + e.toString());
            }


            if (authenticated) {

              ay = true;

            }

            break;

          }




      }
    */


    } ///end of Android platform



    if (Platform.isIOS) {
      switch (availableBiometrics.toString()) {
        case '[BiometricType.face]' :
          {
            ///  debugPrint("worked!! face ");

            try {
              authenticated = await auth.authenticate(
                  localizedReason: 'أستخدم بصمة الوجه',
                  iOSAuthStrings: IOSAuthMessages(
                    lockOut: "بصمة الوجه",
                    cancelButton: 'الغاء',
                    goToSettingsButton: 'أعدادات',
                    goToSettingsDescription: 'أضبط بصمتك',
                  ),
                  useErrorDialogs: false,
                  stickyAuth: true);
            }

            on PlatformException catch (e) {
              print(e);
            }


            if (authenticated) {
              ay = true;
            }

            break;
          }


        case '[BiometricType.fingerprint]' :
          {
            /// debugPrint("worked!! finger ");

            try {
              authenticated = await auth.authenticate(

                  localizedReason: 'أستخدم بصمة الأصبع',
                  iOSAuthStrings: IOSAuthMessages(
                    lockOut: "بصمة الأصبع",
                    cancelButton: 'الغاء',
                    goToSettingsButton: 'أعدادات',
                    goToSettingsDescription: 'أضبط بصمتك',

                  ),
                  useErrorDialogs: false,
                  stickyAuth: true);
            }

            on PlatformException catch (e) {
              print(e);
            }


            if (authenticated) {
              ay = true;
            }

            break;
          }


      }


    } /// end of iosPlatform

    return ay;
  }///end of auth method






}

