import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/data/user_data.dart';

class ProductDataModel {
  String productName;
  int productPrice;
  String productImage;
  num productRating;
  int productStock;

  ProductDataModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productRating,
    required this.productStock,
  });

  factory ProductDataModel.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ProductDataModel(
      productName: doc['title'],
      productPrice: doc['price'],
      productImage: doc['thumbnail'],
      productRating: doc['rating'],
      productStock: doc['stock'],
    );
  }

}
