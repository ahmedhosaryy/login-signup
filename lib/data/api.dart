import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/data/product_data_model.dart';
 class DataSource {
   static List<ProductDataModel> listOfProduct = [];

   static Future<void> getProductsFromApi() async {
     try {
       debugPrint('getProductsFromApi loading');

       final response = await http.get(
         Uri.parse('https://dummyjson.com/products'),
       );

       debugPrint(response.body);

      if (response.statusCode == 200) {
         Map<String, dynamic> apiData = jsonDecode(response.body);

         for (Map<String, dynamic> p in apiData['products']) {
           ProductDataModel product = ProductDataModel as ProductDataModel;

          listOfProduct.add(product);
         }
       }
     } catch (error) {
       debugPrint('Error: $error');
     }
   }
 }
