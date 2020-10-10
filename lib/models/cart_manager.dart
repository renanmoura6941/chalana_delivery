import 'package:chalana_delivery/models/cart_product.dart';
import 'package:chalana_delivery/models/product.dart';
import 'package:chalana_delivery/models/user.dart';
import 'package:chalana_delivery/models/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User user;

  double productPrice = 0.0;

  void updateUser(UserManager userManager) {
    user = userManager.user;

    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  //PEGAR CARRINHO DO USUÁRIO NO FIREBASE
  Future<void> _loadCartItems() async {
    print('______________________________________________________\n');
    print("usuário: ${user.name}\n");
    print('carrengando Items do carrinho no FIREBASE\n');

    //PEGANDO DADOS DOCUMENTOS DO CARRINHO DO USUÁRIO
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    print('tamanho do carrino no FIREBASE: ${cartSnap.documents.length}\n');

    //CRIANDO O OBJETO CARRINHO DO USUÁRIO
    items = cartSnap.documents
        .map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdated))
        .toList();
    print('tamanho do carrino no local: ${items.length}\n');

    print('preço total carrinho: $productPrice\n');
    print('______________________________________________________\n\n\n\n\n\n');
  }

  void addToCart(Product product) {
    print('______________________________________________________\n');
    print('Adicionando produto no carrinho\n');
    print('nome: ${product.name}\nID produto: ${product.id}\n');

    try {
      //VERIFICA SE OS PRODUTOS SÃO IQUAIS
      final e = items.firstWhere((p) => p.stackable(product));
      print('produto ja existente no carrinho\n');
      e.increment();
    } catch (e) {
      print('produto não existente no carrinho\n');
      print('criando produto\n');
      final cartProduct = CartProduct.fromProduct(product);
      print('produto criando\n');

      cartProduct.addListener(_onItemUpdated);

      print('adicionando produto no carrinho local\n');
      items.add(cartProduct);
      print('produto adicionado localmente\n');

      print('criando coleção carrinho no firebase\n');

      try {
        user.cartReference.add(cartProduct.toCartItemMap()).then((doc) {
          cartProduct.id = doc.documentID;
          _onItemUpdated();
          print('coleção carrinho criada com sucesso no firebase\n');
          print('id do documento criado no firebase ${doc.documentID}\n');
        });
      } catch (error) {
        print('ERRO ao criar a coleção carrinho no firebase\n');
      }
    }
    notifyListeners();
    print('______________________________________________________\n\n\n\n\n\n');
  }

  void _onItemUpdated() {
    productPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        print('\npreparando para remover...\n');
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      print('\npreparando para atualizar...\n');

      productPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
      if (items.isEmpty) {
        print("\n\nATENÇÂO Lista vazia\n\n");
      }
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    print('______________________________________________________\n');

    print('deletando produto\n');
    print(
        'nome: ${cartProduct.product.name}\nID produto: ${cartProduct.productId}\nID do documento no Firebase: ${cartProduct.id}\n');
    print("deletano local\n");
    items.removeWhere((p) => p.id == cartProduct.id);
    print("deletano local(ok!)\n");

    print("deletano Firebase\n");
    user.cartReference.document(cartProduct.id).delete();
    print("deletano Firebase(ok!)\n");

    cartProduct.removeListener(_onItemUpdated);

    notifyListeners();

    print('deletado com sucesso.....\n');
    print('______________________________________________________\n\n\n\n\n\n');
  }

  void _updateCartProduct(CartProduct cartProduct) {
    print('______________________________________________________\n');
    print('atualizando produto no FIREBASE\n');

    print(
        'nome: ${cartProduct.product.name}\nID produto: ${cartProduct.productId}\nID do documento no Firebase: ${cartProduct.id}\nquantidade do produto:${cartProduct.quantity} \npreço do carrinho: $productPrice\n');

    try {
      if (cartProduct.id != null) {
        user.cartReference
            .document(cartProduct.id)
            .updateData(cartProduct.toCartItemMap())
            .catchError((erro) {
          print('ERROR ao atualizar carrinho no FIREBASE\n${erro}\n');
        });
      }
    } catch (error) {
      print(
          'ERROR ao atualizar carrinho no FIREBASE ${cartProduct.id}\n${error}\n');
    }

    print('atualizado com sucesso.....\n');
    print('______________________________________________________\n\n\n\n\n\n');
  }

  bool get isCartValid => items.isEmpty?false:true;

  void checkOut() {
    FlutterOpenWhatsapp.sendSingleMessage("+558599002371", "Hello");
  }


}
