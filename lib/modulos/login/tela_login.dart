
// import 'package:chalana_delivery/modelos/usuario_modelo.dart';
// import 'package:flutter/material.dart';

// class TelaLogin extends StatelessWidget {
//     final Usuario user = Usuario();

//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passworldController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldkey,
//       appBar: AppBar(
//         title: const Text("Entrar"),
//         actions: [
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pushReplacementNamed('/signup');
//             },
//             textColor: Colors.white,
//             child: const Text(
//               'CRIAR CONTA',
//               style: TextStyle(fontSize: 14),
//             ),
//           )
//         ],
//       ),
//       body: Center(
//         child: Card(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           child: Form(
//             key: formkey,
//             child: Scrollbar(
//                   child: ListView(
//                     padding: const EdgeInsets.all(16),
//                     shrinkWrap: true,
//                     children: <Widget>[
//                       TextFormField(
//                         //enabled: !user.loading,
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           hintText: 'E-mail',
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         autocorrect: false,
//                         validator: (email) {
//                           // if (!emailValid(email)) {
//                           //   return 'E-mail inválido';
//                           // } else {
//                           //   return null;
//                           // }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       TextFormField(
//                        // enabled: !user.loading,
//                         controller: passworldController,
//                         decoration: const InputDecoration(
//                           hintText: 'Senha',
//                         ),
//                         obscureText: true,
//                         autocorrect: false,
//                         validator: (passworld) {
//                           if (passworld.isEmpty || passworld.length < 6) {
//                             return 'Senha inválida';
//                           }
//                           return null;
//                         },
//                       ),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: FlatButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           child: const Text('Esqueci minha senha'),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       SizedBox(
//                         height: 44,
//                         child: RaisedButton(
//                           onPressed: (){}
//                           // user.loading
//                           //     ? null
//                           //     : () {
//                           //         if (formkey.currentState.validate()) {
//                           //           user.sigIn(
//                           //               user: Usuario(
//                           //                   email: emailController.text,
//                           //                   passworld:
//                           //                       passworldController.text),
//                           //               onFail: (e) {
//                           //                 scaffoldkey.currentState.showSnackBar(
//                           //                   SnackBar(
//                           //                     content:
//                           //                         Text('Falha ao entrar: $e'),
//                           //                     backgroundColor: Colors.red,
//                           //                   ),
//                           //                 );
//                           //               },
//                           //               onSuccess: () {
//                           //                 Navigator.of(context).pop();
//                           //               });
//                           //         }
//                           //       },
//                           ,
//                           disabledColor:
//                               Theme.of(context).primaryColor.withAlpha(100),
//                           color: Theme.of(context).primaryColor,
//                           textColor: Colors.white,
//                           child:
//                                 const Text(
//                                   "Entrar",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                           //  user.loading
//                           //     ? const CircularProgressIndicator(
//                           //         valueColor:
//                           //             AlwaysStoppedAnimation(Colors.white),
//                           //       )
//                           //     : const Text(
//                           //         "Entrar",
//                           //         style: TextStyle(fontSize: 18),
//                           //       ),
//                         ),
//                       )
//                     ],
//                   ),
                
//             )
            
//           ),
//         ),
//       ),
//     );
//   }
// }
