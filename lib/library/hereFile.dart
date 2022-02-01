import 'package:accounts/infoModel/Model.dart';
import 'dart:io';
import 'package:accounts/library/filePath.dart';
import 'package:flutter/cupertino.dart';
import 'package:csv/csv.dart';

class CreateFile {

   FilePath getPath = new FilePath();

  Future<File>  localFile(String name) async {
    final path = await getPath.appFile();
    return File('$path/$name');
  }


  Future<File> saveAsCsvFile(String fileName, List<Model> data) async {
    final file = await localFile(fileName);

    List<List<dynamic>> col = new List<List<dynamic>>();
    for (int i = 0; i <data.length;i++) {
      List<dynamic> row = List();

      row.add(data[i].id);
      row.add(data[i].gName);
      row.add(data[i].gEmail);
      row.add(data[i].gPassword);

      col.add(row);

      String csv = const ListToCsvConverter().convert(col);

      file.writeAsString('$csv' + '\n', mode: FileMode.write, flush: true);

    }

  return file ;
  }

  Future<File> saveAsTextFile(String fileName, List<Model> list) async {
    final file = await localFile(fileName);
    List<String> infoList = new List<String>();
    list.forEach((user)
    {
      infoList.add("${user.toMap()}");
      file.writeAsString('$infoList\n', flush: true);
    });

    return file ;
  }








}