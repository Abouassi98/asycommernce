import 'package:asycommernce/model/cart.dart';
import 'package:asycommernce/model/product.dart';
import '../provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './product_detail.dart';
import 'cart_page.dart';
import '../provider/cart.dart';
import 'package:badges/badges.dart';

class Products extends StatefulWidget {
  static const routedname = '/Products';
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isLood = false;
  Future<List<Product>> getProducts() async {
    var url = 'http://192.168.1.2:1337/products';
    final response = await http.get(url);

    var stringJson = response.body;
    List<Product> products = productFromJson(stringJson);

    return products;
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      isLood = true;
    });
    await Provider.of<Auth>(
      context,
      listen: false
    ).getUser();
    setState(() {
      isLood = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orination = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('products'),
        leading: Consumer<CartItem>(
          builder: (_, cart, ch) => BadgeIconButton(
            hideZeroCount: false,
            itemCount: cart.itemCount,
            badgeColor: Colors.lime,
            badgeTextColor: Colors.black,
            icon: Icon(Icons.store),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.remove('user');
                  Navigator.pushReplacementNamed(context, '/AuthPage');
                }),
          )
        ],
      ),
      body: isLood
          ? Center(child: CircularProgressIndicator())
          : Container(
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
              child: Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      //  child: Container(),
                      child: FutureBuilder<List<Product>>(
                          future: getProducts(),
                          builder: (context, snapShotFuture) {
                            if (snapShotFuture.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return GridView.builder(
                              itemCount: snapShotFuture.data.length,
                              itemBuilder: (context, i) {
                                Product item = snapShotFuture.data[i];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                                  title: item.name,
                                                  desc: item.description,
                                                  price: item.price,
                                                  photoUrl:
                                                      "http://192.168.1.2:1337${item.picture.url}",
                                                  item: item,
                                                )));
                                  },
                                  child: GridTile(
                                    child: Hero(
                                      tag: item,
                                      child: Image.network(
                                        "http://192.168.1.2:1337${item.picture.url}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GridTileBar(
                                        subtitle: Text(
                                          "\$${item.price}",
                                          style: TextStyle(
                                            backgroundColor: Color(0xBB000000),
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.shopping_cart),
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
                                              : Colors.white,
                                        ),
                                        title: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            item.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        backgroundColor: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          orination == Orientation.portrait
                                              ? 2
                                              : 3,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0,
                                      childAspectRatio:
                                          orination == Orientation.portrait
                                              ? 1.0
                                              : 1.3),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
