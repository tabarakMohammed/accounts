import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';


class FilePath {

  Future<String> appFile() async {
    var dir = await getExternalStorageDirectory();
    var appDir =
    await new Directory('${dir.path}/account').create(recursive: true);
    print(appDir.path);
   // print("Download completed");
    return appDir.path;
  }




   Future<String> get downloadDirectory async{
     Directory downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
     String tempPath = downloadsDirectory.path;
 ///    debugPrint("path from path class : $tempPath");
     return tempPath;

   }

//
//  Future getExFilePath() async {
//    Map<String, String> filesPaths;
//    try {
//      var path = await FilePicker.getFilePath();
//      print(path);
//      if(path.endsWith(".db"))
//      {
//        return filesPaths;
//      } else
//      return null;
//    } catch(e) {
//      print(e);
//      return "error";
//    }
 // }

}