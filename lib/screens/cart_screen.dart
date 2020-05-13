import 'package:ecomapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkout_screen.dart';
import 'login_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  CartScreen(this.cartItems);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _total;

  _getTotal() {
    _total = 0.0;
    this.widget.cartItems.forEach((item) {
      setState(() {
        _total += (item.price - item.discount) * item.quantity;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTotal();
  }

  void _checkOut(List<Product> cartItems) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    if(_userId != null && _userId > 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: cartItems,)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(cartItems: cartItems,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text('Items in Cart'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: this.widget.cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(this.widget.cartItems[index].photo),
              title: Text(this.widget.cartItems[index].name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    '\$${this.widget.cartItems[index].price - this.widget.cartItems[index].discount}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' x ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.cartItems[index].quantity.toString(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' = ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${(this.widget.cartItems[index].price - this.widget.cartItems[index].discount) * this.widget.cartItems[index].quantity}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: Column(children: <Widget>[
                InkWell(
                  child: Icon(Icons.arrow_drop_up, size: 21),
                  onTap: () {
                    setState(() {
                      _total += this.widget.cartItems[index].price -
                          this.widget.cartItems[index].discount;
                      this.widget.cartItems[index].quantity++;
                    });
                  },
                ),
                Text(
                  '${this.widget.cartItems[index].quantity}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  child: Icon(Icons.arrow_drop_down, size: 21),
                  onTap: () {
                    setState(() {
                      if (this.widget.cartItems[index].quantity > 0) {
                        _total -= this.widget.cartItems[index].price -
                            this.widget.cartItems[index].discount;
                        this.widget.cartItems[index].quantity--;
                      }
                    });
                  },
                )
              ]),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Expanded(
                child: Text('   Total : \$$_total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    _checkOut(this.widget.cartItems);
                  },
                  child:
                      Text('Checkout', style: TextStyle(color: Colors.white)),
                ),
              )
            ]),
          )),
    );
  }
}
