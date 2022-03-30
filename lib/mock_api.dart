import 'package:istore/data.dart';

class MockAPI {
  List<Category> _catList = [
    Category(1, "เสื้อผ้า", "https://picsum.photos/id/1059/600/400.jpg"),
    Category(2, "ผลไม้", "https://picsum.photos/id/429/600/400.jpg"),
    Category(3, "อุปกรณ์ IT", "https://picsum.photos/id/3/5616/3744.jpg"),
    Category(4, "แก้ว", "https://picsum.photos/id/3/600/400.jpg"),
    Category(5, "นาฬิกา", "https://picsum.photos/id/357/600/400.jpg")
  ];

  List<Product> _productData = [
    Product(1, 100, "xxx", [
      "https://picsum.photos/id/1005/600/400.jpg",
      "https://picsum.photos/id/1001/600/400.jpg",
      "https://picsum.photos/id/1014/600/400.jpg"
    ]),
    Product(2, 200, "yyy", ["https://picsum.photos/id/1011/600/400.jpg"]),
    Product(3, 250, "zz", ["https://picsum.photos/id/1012/600/400.jpg"]),
    Product(4, 20, "aa", ["https://picsum.photos/id/1025/600/400.jpg"]),
    Product(5, 150, "xx", ["https://picsum.photos/id/22/600/400.jpg"])
  ];

  late Map<Category, List<Product>> _productList;

  MockAPI() {
    _productList = {_catList[0]: _productData.sublist(0, 4)};
  }

  List<Category> getCategories() {
    return _catList;
  }

  List<Product> getProducts(Category category) {
    return _productList[category]!;
  }

  Product getProduct(int productId) {
    return _productData.firstWhere((element) => element.id == productId);
  }
}
