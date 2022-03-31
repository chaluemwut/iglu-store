import 'package:flutter/material.dart';
import 'package:istore/data.dart';
import 'package:istore/mock_api.dart';
import 'package:istore/product_detail.dart';

class ProductList extends StatefulWidget {
  int groupId;

  ProductList({Key? key, required this.groupId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductList();
  }
}

class _ProductList extends State<ProductList> {
  late Category _category;
  late List<Product> _products;

  MockAPI _mockAPI = MockAPI();

  @override
  void initState() {
    _category = _mockAPI
        .getCategories()
        .firstWhere((element) => element.id == widget.groupId);
    _products = _mockAPI.getProducts(_category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${_category.title}")),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_products.length, (index) {
          Product product = _products[index];
          Card c = Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      image: product.imgURL[0]),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("${product.name}")),
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("${product.price}"))
              ],
            ),
          );
          return InkWell(
            key: Key("${product.id}"),
            child: c,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ProductDetail(productId: product.id))),
          );
        }),
      ),
    );
  }
}
