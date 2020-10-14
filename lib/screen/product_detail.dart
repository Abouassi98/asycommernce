import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
class ProductDetail extends StatelessWidget {
  final String title;
  final String desc;
  final String photoUrl;
  final int price;
  final  item;
  ProductDetail({this.photoUrl, this.desc, this.price, this.title, this.item});
  @override
  Widget build(BuildContext context) {
    //final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepOrange[300],
                Colors.deepOrange[400],
                Colors.deepOrange[500],
                Colors.deepOrange[600],
                Colors.deepOrange[700]
              ],
              stops: [
                0.1,
                0.3,
                0.5,
                0.7,
                0.9
              ]),
        ),
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Hero(
                tag: item,
                child: Image.network(
                  photoUrl,
                  // width: orientation == Orientation.portrait ? 600 : 250,
                  // height: orientation == Orientation.portrait ? 400 : 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "\$ ${price}",
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(                icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Provider.of<CartItem>(context,
                    listen: false)
                    .itemishere(item.id)
                    ? Provider.of<CartItem>(context,
                    listen: false)
                    .removeitem(item.id)
                    : Provider.of<CartItem>(context,
                    listen: false)
                    .addItem(
                    desc: item.description,
                    pic:
                    "http://192.168.1.2:1337${item.picture.url}",
                    name: item.name,
                    price: item.price,
                    productId: item.id,
                    quantity: 0);
              },
              color: Provider.of<CartItem>(
                context,
              ).itemishere(item.id)
                  ? Colors.cyan[700]
                  : Colors.white,),
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                desc,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
