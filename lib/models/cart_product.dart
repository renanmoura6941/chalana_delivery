import 'package:chalana_delivery/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CartProduct extends ChangeNotifier {
  
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;

    //BUSCANDO O PRODUTO RELACIONADO AO CARRINHO DOS USUÁRIOS
    //CRIANDO O PRODUTO
    firestore.document('products/$productId').get().then((doc) {
      product = Product.formDocument(doc);
      notifyListeners();
    });
  }

  final Firestore firestore = Firestore.instance;

  String id;
  String productId;
  int quantity;
  Product product;

  double get unitPrice {
    if (product == null) return 0;
    return product.price.price;
  }

  double get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {'pid': productId, 'quantity': quantity};
  }

  bool stackable(Product product) {
    return product.id == productId;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    if (product.hasStock == null) {
      return false;
    } else if (product.hasStock) {
      return product.stock >= quantity;
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return 'Firebase id: $id\n produto id: $productId\n quantidade no carrinho: $quantity\n${product.toString()}\n';
  }
}
