import 'dart:convert';

import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/services/product_service.dart';
import 'package:ecomapp/widgets/product_by_category.dart';
import 'package:flutter/material.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  ProductsByCategoryScreen({this.categoryName, this.categoryId});
  @override
  _ProductsByCategoryScreenState createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {

  ProductService _productService = ProductService();

  List<Product> _productListByCategory = List<Product>();

  _getProductsByCategory() async {
    var products = await _productService.getProductsByCategoryId(this.widget.categoryId);
    var _list = json.decode(products.body);
    _list['data'].forEach((data){
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = int.parse(data['price']);
      model.discount = int.parse(data['discount']);
      model.productDetail = data['detail'];

      setState(() {
        _productListByCategory.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getProductsByCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.categoryName),
      ),

      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: _productListByCategory.length,
          itemBuilder: (context, index){

            return ProductByCategory(this._productListByCategory[index]);

          },
        ),
      ),
    );
  }
}