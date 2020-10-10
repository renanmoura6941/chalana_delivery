import 'package:chalana_delivery/helpers/validators_functions.dart';
import 'package:chalana_delivery/models/user.dart';
import 'package:chalana_delivery/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passworldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text("Entrar"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        enabled: !userManager.loading,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'E-mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'E-mail inválido';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        controller: passworldController,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                        ),
                        obscureText: true,
                        autocorrect: false,
                        validator: (passworld) {
                          if (passworld.isEmpty || passworld.length < 6) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formkey.currentState.validate()) {
                                    userManager.sigIn(
                                        user: User(
                                            email: emailController.text,
                                            passworld:
                                                passworldController.text),
                                        onFail: (e) {
                                          scaffoldkey.currentState.showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Falha ao entrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSuccess: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                },
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  "Entrar",
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
