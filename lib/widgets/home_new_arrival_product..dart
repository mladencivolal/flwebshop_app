import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomeNewArrivalProduct extends StatefulWidget {
  final Product product;

  HomeNewArrivalProduct(this.product);
  @override
  _HomeNewArrivalProductState createState() => _HomeNewArrivalProductState();
}

class _HomeNewArrivalProductState extends State<HomeNewArrivalProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
      child: InkWell(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(this.widget.product)));
        },
              child: Card(
          child: Column(
            children: <Widget>[
              Text(this.widget.product.name),
              Image.network(widget.product.photo, width: 190.0, height: 160.0,),            
            ],
          ),
        ),
      ),
    );
  }
}