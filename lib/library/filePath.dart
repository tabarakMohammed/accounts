import 'dart:io';
import 'package:path_provider/path_provider.dart';


class FilePath {

  Future<String> appFile() async {
    var dir = await getExternalStorageDirectory();
    var appDir =
    await new Directory('${dir.path}/account').create(recursive: true);
    print(appDir.path);
   // print("Download completed");
    return appDir.path;
  }


}