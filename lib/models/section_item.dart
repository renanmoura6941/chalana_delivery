import 'package:chalana_delivery/models/section.dart';

class SectionItem {

  SectionItem.fromMap(Map<String,dynamic> map){
    image = map['image'] as String;
    product =  map['product'] as String;

  }

  String image;
  String product;



  

  @override
  String toString() => 'SectionItem(image: $image, product: $product)';
}
