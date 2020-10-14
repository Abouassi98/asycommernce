import 'package:asycommernce/screen/product_detail.dart';
import 'package:flutter/material.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:asycommernce/model/product.dart';
import '../provider/auth.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<Product>> getProducts() async {
    var url = 'http://192.168.1.2:1337/products';
    final response = await http.get(url);

    var stringJson = response.body;
    List<Product> products = productFromJson(stringJson);

    return products;
  }

  Widget cartTab() {
    return Container();
  }

  Widget cardsTab() {
    return Text('b');
  }

  Widget orderTab() {
    return Text('c');
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orination = MediaQuery.of(context).orientation;
    final cart = Provider.of<CartItem>(context, listen: false);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart Page'),
          bottom: TabBar(
            tabs: [
              Icon(Icons.shopping_cart),
              Icon(Icons.credit_card),
              Icon(Icons.receipt)
            ],
            labelColor: Colors.deepOrange[600],
            unselectedLabelColor: Colors.deepOrange[900],
          ),
        ),
        body: FutureBuilder<List<Product>>(
            future: getProducts(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                children: [
                  GridView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                    title: cart.iteams.values.toList()[i].name,
                                    desc: cart.iteams.values
                                        .toList()[i]
                                        .description,
                                    price: cart.iteams.values.toList()[i].price,
                                    photoUrl:
                                        cart.iteams.values.toList()[i].picture,
                                    item: cart.iteams.values.toList()[i],
                                  )));
                        },
                        child: GridTile(
                            child: Hero(
                              tag: cart.iteams.values.toList()[i],
                              child: Image.network(
                                cart.iteams.values.toList()[i].picture,
                                fit: BoxFit.cover,
                              ),
                            ),
                            footer: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridTileBar(
                                subtitle: Text(
                                  "\$${cart.iteams.values.toList()[i].price}",
                                  style: TextStyle(
                                    backgroundColor: Color(0xBB000000),
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {},
                                  color: Colors.white,
                                ),
                                title: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    cart.iteams.values.toList()[i].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                backgroundColor: Colors.black87,
                              ),
                            )),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orination == Orientation.portrait ? 2 : 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio:
                            orination == Orientation.portrait ? 1.0 : 1.3),
                  ),
                  cardsTab(),
                  orderTab(),
                ],
              );
            }),
      ),
    );
  }
}
