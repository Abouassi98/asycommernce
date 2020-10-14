import 'package:flutter/material.dart';
import './screen/auth_.dart';
import './screen/products.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screen/splashScreen.dart';
import './provider/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final user = prefs.getString('user');
  print("user=$user");
  final token = prefs.getString('token');
  print("token=$token");
  runApp(MyApp(
    token: token,
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final String user;
  final String token;
  MyApp({this.user, this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
               ChangeNotifierProvider.value(value: CartItem()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200],
            textTheme: TextTheme(
                headline: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
                title: TextStyle(
                  fontSize: 36,
                  fontStyle: FontStyle.italic,
                ),
                body1: TextStyle(
                  fontSize: 24,
                )),
          ),
          home: token != null
              ? Products()
              : FutureBuilder(
                  future: auth.tryAutoAuth(),
                  builder: (cotext, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthPage(),
                ),
          routes: {
            '/Products': (BuildContext context) => Products(),
            '/AuthPage': (BuildContext context) => AuthPage(),
          },
        ),
      ),
    );
  }
}
