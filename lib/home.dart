import 'package:flutter/material.dart';
import 'package:istore/data.dart';
import 'package:istore/mock_api.dart';
import 'package:istore/product_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State {
  List<Category> _apiMocking = MockAPI().getCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(children: [
        Padding(
            padding: EdgeInsets.only(top: 15, bottom: 5),
            child: Text('Category')),
        ...List.generate(_apiMocking.length, (index) {
          Category category = _apiMocking[index];
          Card c = Card(
            child: Column(
              children: [
                SizedBox(
                  // height: 100,
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      fit: BoxFit.cover,
                      image: category.imgURL),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("${category.title}"))
              ],
            ),
          );
          return InkWell(
            child: c,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ProductList(groupId: category.id))),
          );
        })
      ]),
    ));
  }
}
