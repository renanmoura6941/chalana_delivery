import 'package:chalana_delivery/models/cart_manager.dart';
import 'package:chalana_delivery/models/home_manager.dart';
import 'package:chalana_delivery/models/product.dart';
import 'package:chalana_delivery/models/product_manager.dart';
import 'package:chalana_delivery/models/user_manager.dart';
import 'package:chalana_delivery/screens/base/base_screen.dart';
import 'package:chalana_delivery/screens/cart/cart_screen.dart';
import 'package:chalana_delivery/screens/individual_product/individual_product_screen.dart';
import 'package:chalana_delivery/screens/login/login_Screen.dart';
import 'package:chalana_delivery/screens/signup/signup_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//chalanadelivery@gmail.com chalana12345
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => HomeManager(),
        lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          //const Color.fromRGBO(73, 200, 233,1),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());

            case '/IndividualProductScreen':
              return MaterialPageRoute(
                  builder: (_) =>
                      IndividualProductScreen(settings.arguments as Product));
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
        //  home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BaseScreen());
  }
}

