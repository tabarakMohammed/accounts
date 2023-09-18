

import 'dart:io';
import 'package:file_cryptor/file_cryptor.dart';

import 'filePath.dart';

class encrptFiles{



  FileCryptor fileCryptor = FileCryptor(
    key: "Your 32 bit key.................",
    iv: 16,
    dir: "example",
    // useCompress: true,
  );

  Future<File?> writeFile(File pathin,String pathout) async {

     File encryptedFile =
     await fileCryptor.encrypt(inputFile: pathin.path,
         outputFile: pathout);
     return encryptedFile;
  }


   Future<File?> readFile(String pathIn ) async {

     FilePath getPath = new FilePath();
     final pathD = await getPath.appFile();

     File encryptedFile =
     await fileCryptor.decrypt(inputFile: pathIn,
         outputFile: '$pathD' + '/back.db');

     return encryptedFile;
  }





}