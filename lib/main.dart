import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zkdating/core/theme/text_theme_manager.dart';
import 'package:zkdating/presentation/views/auth/base_auth.dart';
import 'package:zkdating/presentation/views/dashboard.dart';

import 'data/controllers/dashboard_controller.dart';
import 'presentation/general_widgets/shared_loading.dart';
import 'presentation/splash.dart';
import 'utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(
    ProviderScope(
      child: OKToast(
        child: MaterialApp(
          title: 'ZK Dating',
          themeMode: ThemeMode.system,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const ZkDatingSplash(),
        ),
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<String> getEmailFuture;
  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider);

  // This widget is the root of your application.
  @override
  void initState() {
    getEmailFuture = screenController.getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: "ZK Dating",
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF662D66)),
            useMaterial3: true,
            textTheme: zkDatingTheme,
          ),
          home: Stack(
            children: [
              FutureBuilder<String?>(
                future: screenController.getEmail(),
                builder: ((context, snapshot) {
                  String? email = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (email == null || email == "") {
                      return const BaseAuth();
                    } else {
                      return const Dashboard();
                    }
                  } else {
                    return const TransparentLoadingScreen();
                  }
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
