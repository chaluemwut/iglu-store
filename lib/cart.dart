import 'package:flutter/material.dart';
import 'package:istore/beans/cart_bean.dart';
import 'package:istore/system/system_instance.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Cart();
  }
}

class _Cart extends State<Cart> {
  int _total = 0;

  @override
  void initState() {
    _totalComputation();
    setState(() {});
    super.initState();
  }

  int _totalComputation() {
    int total = 0;
    for (CartBean cartBean in SystemInstance().cartBeans) {
      total = total + (cartBean.itemCount * cartBean.price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    int total = _totalComputation();
    return Scaffold(
      appBar: AppBar(
        title: Text("การซื้อสินค้า"),
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text('รายการสินค้า'))),
          ...List.generate(SystemInstance().cartBeans.length, (index) {
            CartBean cartBean = SystemInstance().cartBeans.elementAt(index);
            Container c = Container(
                height: 80,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    SizedBox(
                        height: 50,
                        child: FadeInImage.assetNetwork(
                            placeholder: "assets/loading.gif",
                            image: cartBean.imgURL)),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text("${cartBean.name}"),
                    Row(children: [
                      IconButton(
                          key: Key("add_btn"),
                          onPressed: () {
                            cartBean.itemCount = cartBean.itemCount + 1;
                            setState(() {});
                          },
                          icon: Icon(Icons.add_circle)),
                      Text(
                        "${cartBean.itemCount}",
                        key: Key("item_count_txt"),
                      ),
                      IconButton(
                          key: Key("remove_btn"),
                          onPressed: () {
                            if (cartBean.itemCount == 1) {
                              SystemInstance().cartBeans.remove(cartBean);
                            } else {
                              cartBean.itemCount = cartBean.itemCount - 1;
                            }
                            setState(() {});
                          },
                          icon: Icon(Icons.remove_circle))
                    ]),
                    Text(
                      "${cartBean.itemCount}x${cartBean.price} = ${cartBean.itemCount * cartBean.price}",
                      key: Key("price_txt"),
                    )
                  ],
                ));
            return Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5), child: c);
          }),
          Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Align(
                  child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text("ราคารวม ${total}", key: Key("total_txt"))),
                  alignment: Alignment.bottomRight)),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(hintText: ": ระบุที่อยู่ของผู้ซื้อ"),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ElevatedButton(
                  onPressed: () {
                    SystemInstance().cartBeans.clear();
                    Navigator.of(context).pushReplacementNamed('/Home');
                  },
                  child: Text('ซื้อ')))
        ],
      ),
    );
  }
}
