import 'dart:developer';

import 'package:chalana_delivery/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    print('Preparando para carregar os anúncios da home\n');
    _loadSections();
  }

  List<Section> sections = [];

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    print('______________________________________________________\n');
    print('carragendo items da home no FIREBASE\n');

    firestore.collection('home').snapshots().listen((snapshots) {
      print('Escultando alteraçõas na home FIREBASE\n');
      print('Limpando a lista de seções\n');

      sections.clear();

      print('Limpando a lista de seções concluidá\n');
      print('adicionando dados do firebase na lista de seções da home\n');

      for (final DocumentSnapshot document in snapshots.documents) {
        sections.add(Section.fromDocument(document));
      }
      print('dados adicionados com sucesso!\n');

      print('dados: $sections');
      print('finalizando carregamento de dados da home no firebase\n');
      print(
          '______________________________________________________\n\n\n\n\n\n\n\n');
    
    notifyListeners();
    });
    
  }
}
