import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget gridView() {
    List<int> data = List.generate(10, (index) => index);
    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(data.length, (index) {
        return Card();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              gridView(),
            ],
          ),
        ),
      )),
    );
  }
}
