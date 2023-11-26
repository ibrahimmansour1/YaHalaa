import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yahalaa/core/utils/constants.dart';
import 'package:yahalaa/core/utils/roots/app_router.dart';
import 'package:yahalaa/core/utils/services/local_services/cache_helper.dart';
import 'package:yahalaa/core/utils/services/remote_services/service_locator.dart';
import 'package:yahalaa/core/utils/theme/app_theme.dart';
import 'package:yahalaa/features/agenda/presentation/view_models/dated_all_sessions_cubit/dated_all_sessions_cubit.dart';
import 'package:yahalaa/features/auth/data/repos/auth_repo_impl.dart';
import 'package:yahalaa/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:yahalaa/features/my_schedule/presentation/view_models/dated_subscribed_sessions.cubit/dated_subscribed_sessions_cubit.dart';
import 'package:yahalaa/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:yahalaa/features/notifications/presentation/view_models/notifications_cubit.dart';
import 'package:yahalaa/features/orginizer/scan_qr/data/repos/scan_repo/scan_repo_impl.dart';
import 'package:yahalaa/features/orginizer/scan_qr/presentation/view_models/scan_cubit/scan_cubit.dart';
import 'package:yahalaa/features/profile/data/repos/edit_profile_repo_impl.dart';
import 'package:yahalaa/features/profile/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:yahalaa/features/profile/presentation/view_model/upload_image_profile/upload_image_profile_cubit.dart';
import 'package:yahalaa/features/sessions/data/repos/sessions_repo/sessions_repo_impl.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/all_sessions_cubit/all_sessions_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/book_session_cubit/book_sessions_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/cancel_session_cubit/cancel_sessions_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/get_session_evaluation_cubit/get_session_evaluation_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/post_session_evaluation_cubit/post_session_evaluation_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/specific_session_cubit/specific_sessions_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/subscribed_sessions_cubit/subscribed_sessions_cubit.dart';
import 'package:yahalaa/features/sessions/presentations/view_models/toggle_cubit/toggle_cubit.dart';
import 'package:yahalaa/features/user/home/data/repos/event_repo/event_repo_impl.dart';
import 'package:yahalaa/features/user/home/presentation/view_models/event_cubit/event_cubit.dart';
import 'package:yahalaa/features/user/projects/data/repos/project_reop/projects_repo_impl.dart';
import 'package:yahalaa/features/user/projects/presentation/view_models/project_evaluation_cubit/project_evaluation_cubit.dart';
import 'package:yahalaa/features/user/projects/presentation/view_models/projects_cubit/all_projects_cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

final StreamSubscription<InternetConnectionStatus> listener =
    InternetConnectionChecker().onStatusChange.listen(
  (InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        debugPrint('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        // ignore: avoid_print
        debugPrint('You are disconnected from the internet.');
        break;
    }
  },
);

Future<void> execute(
  InternetConnectionChecker internetConnectionChecker,
) async {
  debugPrint(
      '''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  debugPrint(
    isConnected.toString(),
  );
  debugPrint(
    'Current status: ${await InternetConnectionChecker().connectionStatus}',
  );
}

hasConnection() async {
  AppConstants.hasConnectionResult =
      await InternetConnectionChecker().hasConnection;
  if (AppConstants.hasConnectionResult == true) {
    debugPrint('YAY! Free cute dog pics!');
  } else {
    debugPrint('No internet :( Reason:');
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await execute(InternetConnectionChecker());
  final InternetConnectionChecker customInstance =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );
  await execute(customInstance);
  debugPrint("0" * 20);
  hasConnection();
  debugPrint("0" * 20);
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint(
        '================================ FOREGROUND NOTIFICATION ================================');
    debugPrint(message.data.toString());
    debugPrint('Notification title: ${message.notification!.title}');
    debugPrint('Notification body: ${message.notification!.body}');
  });
  FirebaseMessaging.instance.getToken().then((value) {
    debugPrint(value.toString());
    CacheHelper.saveData(key: 'FCM_Token', value: value).then((value) {
      if (value) {
        AppConstants.fcmToke = CacheHelper.getData(key: 'FCM_Token');
        debugPrint('${'=' * 10} FCM TOKEN ${'=' * 10}');
        debugPrint(AppConstants.fcmToke);
        debugPrint('=' * 30);
      } else {
        debugPrint('ERROR IN GETTING FCM TOKEN');
      }
    });
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  setup();
  FirebaseMessaging firebaseMessaging =
      FirebaseMessaging.instance; // Change here
  firebaseMessaging.getToken().then((token) {
    CacheHelper.saveData(key: "device_token", value: token);
    print("token is $token");
  });
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("en")],
        startLocale: const Locale("en"),
        path:
            "lib/core/language", // <-- change the path of the translation files
        child: const ResiThon()),
  );
}

class ResiThon extends StatelessWidget {
  const ResiThon({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginCubit(
                  getIt.get<AuthRepoImpl>(),
                )),
        BlocProvider(create: (context) => UploadImageProfileCubit()),
        BlocProvider(
            create: (context) => EditProfileCubit(
                  getIt.get<EditProfileRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => EventCubit(
                  getIt.get<EventRepoImpl>(),
                )..eventDetails()),
        BlocProvider(create: (context) => ToggleCubit()),
        BlocProvider(
            create: (context) => AllSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )..sessionsDetails()),
        BlocProvider(
            create: (context) => DatedAllSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => DatedSubscribedSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => SpecificSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => SubscribedSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )..subscribedSessionsDetails()),
        BlocProvider(
            create: (context) => BookSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => ProjectEvaluationCubit(
                  getIt.get<ProjectsRepoImpl>(),
                )..projectEvaluationDetails()),
        BlocProvider(
            create: (context) => CancelSessionsCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => GetSessionEvaluationCubit(
                  getIt.get<SessionsRepoImpl>(),
                )..getSessionEvaluationDetails()),
        BlocProvider(
            create: (context) => PostSessionEvaluationCubit(
                  getIt.get<SessionsRepoImpl>(),
                )),
        BlocProvider(
            create: (context) => AllProjectsCubit(
                  getIt.get<ProjectsRepoImpl>(),
                )..allProjectsDetails()),
        BlocProvider(
          create: (context) =>
              NotificationsCubit(getIt.get<NotificationsRepoImple>())
                ..getNotificationsData(),
        ),
        BlocProvider(
          create: (context) => ScanCubit(getIt.get<ScanRepoImpl>()),
        ),
      ],
      child: MaterialApp.router(
        title: "YaHalaa",
        theme: themeDataLight,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
