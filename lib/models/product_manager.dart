import 'package:chalana_delivery/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductManager extends ChangeNotifier {
  
  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProduct = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filtredProducts {
    final List<Product> filtredProducts = [];

    if (search.isEmpty) {
      filtredProducts.addAll(allProduct);
    } else {
      filtredProducts.addAll(allProduct
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filtredProducts;
  }

  Future<void> _loadAllProducts() async {
    //pegando todos os documentos da coleção products
    final QuerySnapshot snapProducts =
        await firestore.collection('products').getDocuments();

    allProduct =
        snapProducts.documents.map((d) => Product.formDocument(d)).toList();

    notifyListeners();
  }

    Product findProductById(String id){
    try {
      return allProduct.firstWhere((p) => p.id == id);
    } catch (e){
      return null;
    }
  }

}
