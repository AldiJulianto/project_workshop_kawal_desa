import 'package:get_it/get_it.dart';
import 'package:project_workshop_kawal_desa/services/alert_service.dart';
import 'package:project_workshop_kawal_desa/services/api_service.dart';
import 'package:project_workshop_kawal_desa/services/database_handler.dart';
import 'package:project_workshop_kawal_desa/services/ftp_service.dart';
import 'package:project_workshop_kawal_desa/services/geolocator_service.dart';
import 'package:project_workshop_kawal_desa/services/location_service.dart';
import 'package:project_workshop_kawal_desa/services/navigation_service.dart';
import 'package:project_workshop_kawal_desa/services/rmq_service.dart';
import 'package:project_workshop_kawal_desa/services/storage_service.dart';
import 'package:project_workshop_kawal_desa/services/database_handler.dart';


GetIt locator = GetIt.instance;
//MElakukan inisiasi untuk dapat memanggil sleuruh servicce
void setUpLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => GeolocatorService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => RmqService());
  locator.registerLazySingleton(() => FtpService());
  locator.registerLazySingleton(() => DatabaseHandler());
}