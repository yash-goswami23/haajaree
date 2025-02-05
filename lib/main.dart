import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:haajaree/bloc/auth_bloc/auth_bloc.dart';
import 'package:haajaree/bloc/home_bloc/home_bloc.dart';
import 'package:haajaree/bloc/progress_bloc/progress_bloc_bloc.dart';
import 'package:haajaree/bloc/user_bloc/user_bloc.dart';
import 'package:haajaree/bloc/which_screen_bloc/which_screen_bloc.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';
import 'package:haajaree/data/repositories/database_repository.dart';
import 'package:haajaree/data/repositories/notification_service.dart';
import 'package:haajaree/data/services/admob_service/admob_service.dart';
import 'package:haajaree/firebase_options.dart';
import 'package:haajaree/routes/routes.dart';
import 'package:haajaree/routes/routes_names.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundNotificationHeandle);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AdmobService.initialize();
  runApp(const MainApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundNotificationHeandle(
    RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.handleNotifications();
    notificationService.getDeviceToken().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final authRepo = AuthRepository(firebaseAuth);
    final dbRepo = DatabaseRepository(firestore, authRepo);

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc(authRepo),
      ),
      BlocProvider(
        create: (context) => UserBloc(dbRepo, authRepo),
      ),
      BlocProvider(
        create: (context) => HomeBloc(dbRepo),
      ),
      BlocProvider(
        create: (context) => WhichScreenBloc(authRepo, dbRepo),
      ),
      BlocProvider(
        create: (context) => ProgressBloc(authRepo, dbRepo),
      ),
    ], child: WhichScreens(authRepo: authRepo, dbRepo: dbRepo));
  }
}

class WhichScreens extends StatefulWidget {
  final AuthRepository authRepo;
  final DatabaseRepository dbRepo;
  const WhichScreens({super.key, required this.authRepo, required this.dbRepo});

  @override
  State<WhichScreens> createState() => _WhichScreensState();
}

class _WhichScreensState extends State<WhichScreens> {
  late final User? currentUser;
  UserModel? userData;
  @override
  void initState() {
    super.initState();
    context.read<WhichScreenBloc>().add(CheckWhichScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhichScreenBloc, WhichScreenState>(
      builder: (context, state) {
        if (state is InMainScreen) {
          return _buildMateralApp(mainPage);
        } else if (state is InWelcomeScreen) {
          return _buildMateralApp(welcomeScreen);
        } else {
          AdmobService.showAppOpenAd();
          return Center(
            child: LoadingAnimationWidget.inkDrop(
                color: const Color(whiteColor), size: 45),
          );
        }
      },
    );
  }

  _buildMateralApp(String initalRoute) {
    AdmobService.showAppOpenAd();
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(bgColor),
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: initalRoute,
    );
  }
}
