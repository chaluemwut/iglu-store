import 'package:istore/beans/cart_bean.dart';

class SystemInstance {
  static final SystemInstance _instance = SystemInstance._internal();

  factory SystemInstance() {
    return _instance;
  }

  SystemInstance._internal() {}

  Set<CartBean> _cartBeans = Set();

  Set<CartBean> get cartBeans => _cartBeans;

  set cartBeans(Set<CartBean> value) {
    _cartBeans = value;
  }
}
