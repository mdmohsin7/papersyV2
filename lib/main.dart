import 'package:async_redux/async_redux.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/utils/theme_data.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/routes/route_generator.dart';
import 'package:papersy/confidential/confidential_data.dart';
import './client/screens/home/home_widget.dart';
import 'client/screens/theme_connector.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  print(Firebase.apps.length);
  if (Firebase.apps.length < 2) {
    await Firebase.initializeApp(
      name: "v2",
      options: FirebaseOptions(
        appId: ConfidentialData.appId,
        apiKey: ConfidentialData.apiKey,
        projectId: ConfidentialData.projectId,
        messagingSenderId: ConfidentialData.messagingSenderId,
      ),
    );
  }
  if (Firebase.app("v2") == null) {
    await Firebase.initializeApp(
      name: "v2",
      options: FirebaseOptions(
        appId: ConfidentialData.appId,
        apiKey: ConfidentialData.apiKey,
        projectId: ConfidentialData.projectId,
        messagingSenderId: ConfidentialData.messagingSenderId,
      ),
    );
  }
  FirebaseAdMob.instance.initialize(appId: Values.appId);
  NavigateAction.setNavigatorKey(navigatorKey);
  await FlutterDownloader.initialize();
  store = Store<AppState>(
    initialState: AppState.initialState(),
  );
  runApp(MyApp());
}

Store<AppState> store;
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, TVM>(
        vm: ThemeVM(),
        builder: (context, tvm) => FeatureDiscovery(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: "/",
            onGenerateRoute: RouteGenerator.generateRoute,
            title: 'Papersy',
            theme: tvm.isDark ? AppTheme().darkTheme : AppTheme().lightTheme,
            home: UserExceptionDialog<AppState>(
              onShowUserExceptionDialog: (context, exp) {
                return showDialog(
                  context: context,
                  child: AlertDialog(
                    actions: [
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("close"),
                      )
                    ],
                    title: Text(exp.msg),
                  ),
                );
              },
              child: MyHomePage(title: 'Papersy'),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    msg();
    FeatureDiscovery.discoverFeatures(context, {"filter", "upload"});
  }

  Future<void> msg() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("route ${NavigateAction.getCurrentNavigatorRouteName(context)}");

    return Home();
  }
}
