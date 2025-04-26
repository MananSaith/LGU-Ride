
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:riding_app/utils/app_imports.dart';
import 'package:flutter/material.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  createNotification(
    title: message.data['title'].toString(),
    body: message.data['body'].toString(),
  );
}

Future<void> createNotification(
    {required String title, required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1, channelKey: 'basic_channel', title: title, body: body),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'test',
      ),
    ],
  ).then((value) => print(value));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.dark,
  // ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ErrorString()),
      ChangeNotifierProvider(create: (context) => SignUpBusinessLogic()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => AppState()),
      ChangeNotifierProvider(
        create: (_) => AuthServices.instance(),
      ),
      StreamProvider(
        create: (context) => context.read<AuthServices>().authState,
        initialData: AuthServices.instance().authState,
      )
    ],
    child: EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale:
          const Locale('en'), // Set English as the default startup locale
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    FirebaseAuth.instance.signInAnonymously();
    FirebaseMessaging.instance.requestPermission();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow notifications'.tr()),
              content: Text('Our app wants to send you notifications'.tr()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow'.tr(),
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    // ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        // localizationsDelegates: [
        //   ...context.localizationDelegates,
        //   GlobalMaterialLocalizations.delegate,  // Required for Material components
        //   GlobalCupertinoLocalizations.delegate, // Required for Cupertino components
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'LGU Ride',
        theme: ThemeData(
            fontFamily: "Poppins", scaffoldBackgroundColor: Colors.white),
        // home: AnnotatedRegion<SystemUiOverlayStyle>(
        //     value:
        //         SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        //     child: const SplashView()));
        home: const SplashView());
  }
}
