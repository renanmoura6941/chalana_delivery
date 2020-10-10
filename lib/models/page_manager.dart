import 'package:flutter/material.dart';

class PageManager {

  final PageController _pageController;

  PageManager(this._pageController);

  //pagina selecionada
  int page = 0;

  //Método para mudar de página no drawer
  void setPage(int value) {

    if (value == page) return;

    page = value;

    _pageController.jumpToPage(value);

  }
}
