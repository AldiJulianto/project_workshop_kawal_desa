import 'dart:ui';
import 'package:flutter/material.dart';


const BASE_URL = 'https://absensiselfie-api.pptik.id:5026';
const color_spacecafet = Color(0xff291C14B);
const color_sileverv = Color(0xffD76D2f);
const color_white = Color(0xffEAF2E9);
const color_main = Colors.lightBlueAccent;
const color_independent = Color(0xff325074);
const color_textLitle = Color(0xff123456);

const K_COMPANY = "company";
const K_GUID = "guid";
const K_NAME = "name";
const K_UNIT = "unit";
const K_APP_TYPE = "app_type";
const K_ROLE = "role";
const K_LATITUDE = "latitude";
const K_LONGITUDE = "longitude";
const FTP_URL = "ftpf.absensi-selfie.pptik.id";
const FTP_USER = "absensi_selfie";
const FTP_PASS = "absensi_selfie123|pptikitb";
const FTP_PORT = 2121;

const RMQ_USER = "absensi_selfie";
const RMQ_PASS = "lkjhgfdsa123!";
const RMQ_HOST = "rmq2.pptik.id";
const RMQ_VHOST = "/absensi_selfie";

/* Requirements :
  - ListView
  - FTP Service
  - AMQP Service
  - HTTP Service
 */