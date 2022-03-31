import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:istore/beans/cart_bean.dart';
import 'package:istore/cart.dart';
import 'package:istore/data.dart';
import 'package:istore/mock_api.dart';
import 'package:istore/system/system_instance.dart';

class ProductDetail extends StatefulWidget {
  int productId;

  ProductDetail({Key? key, required this.productId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetail();
  }
}

class _ProductDetail extends State<ProductDetail> {
  late Product _product;
  MockAPI _mockAPI = MockAPI();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  Faker _faker = Faker();
  late String _detail;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _product = _mockAPI.getProduct(widget.productId);
    _detail = _faker.lorem.sentences(10).join("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สินค้า"),
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _product.imgURL != null
                    ? Column(
                        children: [
                          CarouselSlider(
                            items: List.generate(
                                _product.imgURL.length,
                                (index) => FadeInImage.assetNetwork(
                                    placeholder: "assets/loading.gif",
                                    image: _product.imgURL[index])),
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  _current = index;
                                  setState(() {});
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  _product.imgURL.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(_current == entry.key
                                                ? 0.9
                                                : 0.4)),
                                  ),
                                );
                              }).toList())
                        ],
                      )
                    : Padding(padding: EdgeInsets.zero),
                Center(
                    child: ElevatedButton(
                        key: Key("cart_btn"),
                        onPressed: () {
                          SystemInstance systemInstance = SystemInstance();
                          CartBean instanceCartBean = systemInstance.cartBeans
                              .firstWhere(
                                  (element) => element.productId == _product.id,
                                  orElse: () => CartBean(
                                      this._product.id,
                                      this._product.name,
                                      this._product.price,
                                      0,
                                      this._product.imgURL[0]));
                          if (instanceCartBean.itemCount == 0) {
                            systemInstance.cartBeans.add(instanceCartBean);
                          }
                          instanceCartBean.itemCount =
                              instanceCartBean.itemCount + 1;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Cart()));
                        },
                        child: Text('เพิ่มใส่ตะกร้า'))),
                Padding(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    child: Text(_product.name)),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Text("ราคา ${_product.price}"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    "รายละเอียด",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Text(_detail),
                )
              ],
            )
          ],
        ));
  }
}
