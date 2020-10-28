
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final Map<String, dynamic> routes = {
      //  "Conteúdos Gerais": MaterialPageRoute(builder: (_) => GeneralContent(args: args,)),
      //   "Conteúdos Específicos":MaterialPageRoute(builder: (_) => SpecifcContent(args: args)),
      //   "Recursos Didáticos":MaterialPageRoute(builder: (_) => DidacticResources(args: args)),
      //      "development": MaterialPageRoute(builder: (_) => ScreenDevelopment()),
    };
    if (routes.containsKey(settings.name)) {
      return routes[settings.name];
    } else {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'ERROR',
                //textScaleFactor: 0.98,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "Mensagem desenvolvedor:",
                //textScaleFactor: 0.98,
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "Erro na rota",
                //textScaleFactor: 0.98,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      );
    });
  }
}
