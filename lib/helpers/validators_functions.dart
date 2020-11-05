import 'dart:io';

import 'dart:math';

import 'package:chalana_delivery/telas/tela_adicionar_produto/modelo/Imagem_selecionar_modelo.dart';
import 'package:flutter/material.dart';

bool emailValid(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

  return regex.hasMatch(email);
}

bool validarMonetario(String monetario) {
  final RegExp regex = RegExp(r"^[1-9]\d{0,2}(\.\d{3})*,\d{2}$");

  return regex.hasMatch(monetario);
}

String validarPreco(String preco) {
  if (preco.isEmpty) {
    return 'Campo vazio';
  } else {
    return null;
  }
}

String validarNome(String nome) {
  if (nome.isEmpty) {
    return 'Campo vazio';
  } else if (nome.length < 3) {
    return 'nome inválido';
  } else {
    return null;
  }
}

String validarDescricao(String descricao) {
  if (descricao.isEmpty) {
    return 'Campo vazio';
  } else if (descricao.trim().split(' ').length <= 1) {
    return 'descrição muito curta';
  } else {
    return null;
  }
}

bool validarFoto(List<ImagemModeloLocal> imagens, BuildContext context) {
  if (imagens.isEmpty) {
    popAlerta(context, "Sem foto!");
    return false;
  }
  return true;
}

popAlerta(BuildContext context, String mensagem) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            title: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(mensagem)),
          ));
}
