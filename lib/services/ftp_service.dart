import 'dart:io';
//Asal dari variable FTL_URL dll
import 'package:project_workshop_kawal_desa/constants/const.dart';
import 'package:project_workshop_kawal_desa/constants/route_name.dart';
//FTP Client harus install library baru
import 'package:ftpclient/ftpclient.dart';

class FtpService {
  Future<bool> uploadFile(File file, String guid, String ts) async {
    FTPClient client = FTPClient (
      FTP_URL, //const.dart
      user: FTP_USER, //const.dart
      pass: FTP_PASS, //const.dart
      port: FTP_PORT //const.dart
    );
    try {
      client.connect();
      client.changeDirectory('/kehadiran/image');
      await client.uploadFile(file, sRemoteName : '$guid$ts-PPTIK.jpg');
    } catch(e) {
        print("[Upload File] Error $e");
        return false;
    } finally {
        client.disconnect();
    }
    return true;
  }
}