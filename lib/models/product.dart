import 'package:chalana_delivery/models/price.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product extends ChangeNotifier {
  Product.formDocument(DocumentSnapshot document) {
    id = document.documentID;

    name = document['name'] as String;

    description = document['description'] as String;

    images = List<String>.from(document.data['image'] as List<dynamic>);

    //My

    price = Price.fromMap(document['price'] as Map<String, dynamic>);

    stock = document['stock'] as int;

    if (price.hasPricePerKilo) {
      priceOfKiloSelected = price.minimumKilo.toDouble();
    }
    //Myend

    //print(document.data);
  }

  String id;
  String name;
  String description;
  List<String> images;

  //TODO alterar
  // List<ItemSize> sizes;

  // ItemSize _selectedSize;

  // ItemSize get selectedSize => _selectedSize;

  // set selectedSize(ItemSize value) {
  //   _selectedSize = value;

  //   notifyListeners();
  // }

  // int get totalStock {
  //   int stock = 0;
  //   for (final size in sizes) {
  //     stock += size.stock;
  //   }
  //   return stock;
  // }

  // bool get hasStock {
  //   return totalStock > 0;
  // }

//__________________________________________________________________
  //Meus atributos
  Price price;
  double _priceOfKiloSelected;
  double _calculatePrice;
  int _stock;

  double get priceOfKiloSelected {
    return _priceOfKiloSelected;
  }

  set priceOfKiloSelected(double value) {
    _priceOfKiloSelected = value;

    notifyListeners();
    // debugPrint('valordo (Kg) selecionado $_priceOfKiloSelected');
    // debugPrint('preço do kilo ${price.pricePerKilo}');
    // debugPrint('preço a pagar $calculatePrice');
  }

  double get calculatePrice {
    if (price.hasPricePerKilo) {
      return priceOfKiloSelected * price.pricePerKilo;
    } else {
      return price.price;
    }
  }

  set calculatePrice(double price) {
    _calculatePrice = price;
  }

  void stateInital() {
    calculatePrice = price.price;
    priceOfKiloSelected = price.minimumKilo.toDouble();
    // debugPrint("kg selecionado $priceOfKiloSelected");
    // debugPrint("preço com base no kilo selecionado $calculatePrice");
  }

  bool get hasStock {
    return stock > 0;
  }

  int get stock {
    return _stock;
  }

  set stock(int value) {
    _stock = value;
  }

//__________________________________________

  @override
  String toString() {
    return 'Firebase ID $id\nnome: $name\ndescrição: $description\nimagensQTD: $images\npreço: ${price.price}\nstock: $stock\n';
  }
}
