import 'dart:io';

import 'dart:math';

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
  } else if (!validarMonetario(preco)) {
    return 'valor inválido';
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

