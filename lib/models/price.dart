class Price {

  Price.fromMap(Map<String, dynamic> map) {

    price = (map['price'] as num).toDouble();

    hasPricePerKilo = map['hasPriceKilo'] as bool;

    if (hasPricePerKilo) {

      maximumKilo = (map['pricePerKilo']['maximumKilo'] as num).toInt();

      minimumKilo = (map ['pricePerKilo']['minimumKilo'] as num).toInt();

      pricePerKilo =
          (map['pricePerKilo']['pricePerKilo'] as num).toDouble();
          
    }
  }

  double price;
  double pricePerKilo;
  bool hasPricePerKilo;
  int maximumKilo;
  int minimumKilo;
 
}
