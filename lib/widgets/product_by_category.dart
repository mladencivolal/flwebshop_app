import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductByCategory extends StatefulWidget {
  final Product product;
  ProductByCategory(this.product);
  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 190,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(this.widget.product)));
        },
              child: Card(
          child: ListView(
            children: <Widget>[
              Text(this.widget.product.name),
              Image.network(widget.product.photo, width: 190.0, height: 140.0,),
              Row(children: <Widget>[
                Text('Price: ${this.widget.product.price}'),
                Text('Discount: ${this.widget.product.discount}'),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}