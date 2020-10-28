  

import 'package:chalana_delivery/modelos/usuario_modelo.dart';
import 'package:flutter/material.dart';


class TelaCadastrar extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final Usuario user = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Criar conta'),
        ),
        key: scaffoldkey,
        body: Center(
            child: Card(
          margin: const EdgeInsets.all(16),
          child: Scrollbar(
            child: Form(
              key: formkey,
              child: 
                ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                     // enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: 'Nome completo',
                      ),
                      autocorrect: false,
                      onSaved: (name) => user.name = name,
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'preencha seu nome completo';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      //enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onSaved: (name) => user.email = name,
                      validator: (email) {
                        // if (email.isEmpty) {
                        //   return 'Campo obrigatório';
                        // } 
                        // else if (!emailValid(email)) {
                        //   return 'E-mail inválido';
                        // } else {
                        //   return null;
                        // }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      //enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      autocorrect: false,
                      obscureText: true,
                      onSaved: (passworld) => user.passworld = passworld,
                      validator: (passworld) {
                        if (passworld.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (passworld.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      //enabled: !userManager.loading,

                      //controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Confirmar senha',
                      ),

                      autocorrect: false,
                      obscureText: true,
                      onSaved: (confirmPassworld) =>
                          user.confirmPassworld = confirmPassworld,
                      validator: (passworld) {
                        if (passworld.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (passworld.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: () {
                                if (formkey.currentState.validate()) {
                                  formkey.currentState.save();

                                  if (user.passworld != user.confirmPassworld) {
                                    scaffoldkey.currentState.showSnackBar(
                                      const SnackBar(
                                        content: Text('Senhas não coincidem'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }

                                  // userManager.signUp(
                                  //     user: user,
                                  //     onSuccess: () {
                                  //       debugPrint("successo");
                                  //       Navigator.of(context).pop();
                                  //       //TODO:POP
                                  //     },
                                  //     onFail: (e) {
                                  //       scaffoldkey.currentState.showSnackBar(
                                  //         SnackBar(
                                  //           content:
                                  //               Text('Falha ao cadastrar $e'),
                                  //           backgroundColor: Colors.red,
                                  //         ),
                                  //       );
                                  //     });
                                }
                              },
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        //child: userManager.loading
                        child: false
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                "Criar conta",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
        ));
  }
}