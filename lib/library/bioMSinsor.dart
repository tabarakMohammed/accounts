
import 'dart:io';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class BioMetric {





  Future<bool> authenticate() async {


    final LocalAuthentication auth = new LocalAuthentication();

    bool authenticated = false;
    bool ay = false;


    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();


    if (Platform.isAndroid) {
      switch (availableBiometrics.toString()) {

      ///when face
        case '[BiometricType.face]' :
          {

            ///  debugPrint("worked!! face ");

              try {
                authenticated = await auth.authenticateWithBiometrics(

                    localizedReason: 'أستخدم بصمة الوجه',
                    androidAuthStrings: AndroidAuthMessages(
                      fingerprintHint: "متحسس البصمة",
                      fingerprintNotRecognized: "أدخال غير صحيح، لم يتم تميز البصمة ",
                      fingerprintRequiredTitle: "بصمتك مطلوبة !",
                      fingerprintSuccess: "تم بنجاح",
                      signInTitle: "بصمة الوجه",
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

      /// when finger
        case '[BiometricType.fingerprint]' :
          {

            ///  debugPrint("worked!! finger ");
            try {
              authenticated = await auth.authenticateWithBiometrics(

                  localizedReason: 'أستخدم بصمة الأصبع',
                  androidAuthStrings: AndroidAuthMessages(
                    fingerprintHint: "متحسس البصمة",
                    fingerprintNotRecognized: "أدخال غير صحيح، لم يتم تميز البصمة ",
                    fingerprintRequiredTitle: "بصمتك مطلوبة !",
                    fingerprintSuccess: "تم بنجاح",
                    signInTitle: "بصمة الأصبع",
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
    } ///end of Android platform



    if (Platform.isIOS) {
      switch (availableBiometrics.toString()) {
        case '[BiometricType.face]' :
          {
            ///  debugPrint("worked!! face ");

            try {
              authenticated = await auth.authenticateWithBiometrics(
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
              authenticated = await auth.authenticateWithBiometrics(

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

