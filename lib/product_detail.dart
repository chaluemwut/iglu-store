import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:istore/data.dart';
import 'package:istore/mock_api.dart';

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
  int _current = 1;
  final CarouselController _controller = CarouselController();
  Faker _faker = Faker();
  late String _detail;

  @override
  void initState() {
    _product = _mockAPI.getProduct(widget.productId);
    _detail = _faker.lorem.sentences(10).join("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สินค้า"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            _current = index;
                            setState(() {});
                          }),
                      items: List.generate(
                          _product.imgURL.length,
                          (index) => FadeInImage.assetNetwork(
                              placeholder: "assets/loading.gif",
                              image: _product.imgURL[index]))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _product.imgURL.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
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
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList()),
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
          ),
          Positioned(
              bottom: 5,
              child: Positioned(
                  bottom: 5,
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // SystemInstance instance = SystemInstance();
                            // CartBean cart = instance.cart.firstWhere(
                            //         (element) => element.productId == _product['product_id'],
                            //     orElse: () => CartBean(
                            //         productId: _product['product_id'],
                            //         name: _product['name'],
                            //         price: _product['price'],
                            //         discount: _product['discount'],
                            //         itemCount: 0,
                            //         imageId: sliderImage == null ? "" : sliderImage[0]));
                            // cart.itemCount++;
                            // instance.cart.add(cart);
                            // SecurePreferences securePreferences = SecurePreferences();
                            // securePreferences.setString(
                            //     PreferencesDataKey.BUY_ITEM.toDataString(),
                            //     jsonEncode(instance.cart.toList()));
                            // if (instance.token == "") {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (BuildContext context) => LoginProductDetail()));
                            // } else {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (BuildContext context) => Cart()));
                            // }
                          },
                          child: Text('เพิ่มใส่ตระกร้า'),
                        ),
                      ))))
        ],
      ),
    );
  }
}
