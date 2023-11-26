import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:yahalaa/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:yahalaa/features/orginizer/scan_qr/data/repos/scan_repo/scan_repo_impl.dart';
import 'package:yahalaa/features/profile/data/repos/edit_profile_repo_impl.dart';
import 'package:yahalaa/features/sessions/data/repos/sessions_repo/sessions_repo_impl.dart';
import 'package:yahalaa/features/user/home/data/repos/event_repo/event_repo_impl.dart';
import 'package:yahalaa/features/user/projects/data/repos/project_reop/projects_repo_impl.dart';
import '../../../../features/auth/data/repos/auth_repo_impl.dart';
import 'api_service.dart';
//dependency Injection

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<EditProfileRepoImpl>(EditProfileRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<EventRepoImpl>(EventRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<SessionsRepoImpl>(SessionsRepoImpl(
    getIt.get<ApiService>(),
  ));

  getIt.registerSingleton<ProjectsRepoImpl>(ProjectsRepoImpl(
    getIt.get<ApiService>(),
  ));

  getIt.registerSingleton<NotificationsRepoImple>(NotificationsRepoImple(
    getIt.get<ApiService>(),
  ));
  // getIt.registerSingleton<SpeakersChatRepoImpl>(SpeakersChatRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  getIt.registerSingleton<ScanRepoImpl>(ScanRepoImpl(
    getIt.get<ApiService>(),
  ));
}
