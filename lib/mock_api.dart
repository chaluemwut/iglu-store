import 'package:istore/data.dart';

class MockAPI {
  List<Category> _catList = [
    Category(1, "เสื้อผ้า", _imageById(1059)),
    Category(2, "ผลไม้", _imageById(429)),
    Category(3, "อุปกรณ์ IT", _imageById(3)),
    Category(4, "แก้ว", _imageById(113)),
    Category(5, "รถ", _imageById(1072))
  ];

  //ผลไม้ 292, 326, 425, 488, 493 # 517, 674
  //อุปกรณ์ IT 180, 2, 201, 304, 366 # 370, 4, 445
  //แก้ว 225, 30, 431, 490, 529 # 63, 635
  //รถ 1070, 1071, 111, 133, 183 # 655, 670

  List<Product> _productData = [
    //1
    Product(1, 100, "เสื้อแขนยาว",
        [_imageById(1005), _imageById(1001), _imageById(1014)]),
    Product(2, 200, "กางเกงขายาว",
        [_imageById(1011), _imageById(1001), _imageById(1014)]),
    Product(3, 250, "เสื้อเชิ้ต",
        [_imageById(1012), _imageById(1001), _imageById(1014)]),
    Product(4, 20, "ผ้าห่ม",
        [_imageById(1025), _imageById(1001), _imageById(1014)]),
    Product(5, 150, "สูทผู้ชาย",
        [_imageById(22), _imageById(1001), _imageById(1014)]),
    //2
    Product(6, 30, "หอม", [_imageById(292), _imageById(517), _imageById(674)]),
    Product(
        7, 25, "มะนาว", [_imageById(326), _imageById(517), _imageById(674)]),
    Product(8, 15, "กาแฟ", [_imageById(425), _imageById(517), _imageById(674)]),
    Product(9, 10, "พริก", [_imageById(488), _imageById(517), _imageById(674)]),
    Product(10, 40, "สตอเบอรี่",
        [_imageById(493), _imageById(517), _imageById(674)]),
    //3
    Product(
        11, 20000, "Mac I", [_imageById(180), _imageById(370), _imageById(4)]),
    Product(
        12, 30000, "Mac II", [_imageById(2), _imageById(370), _imageById(4)]),
    Product(13, 25000, "Note book",
        [_imageById(201), _imageById(370), _imageById(4)]),
    Product(
        14, 400000, "Mixer", [_imageById(304), _imageById(370), _imageById(4)]),
    Product(15, 3000, "Keyboard",
        [_imageById(366), _imageById(370), _imageById(4)]),
    // 4
    Product(16, 30, "แก้วกาแฟ I",
        [_imageById(225), _imageById(63), _imageById(635)]),
    Product(17, 30, "แก้วกาแฟ II",
        [_imageById(30), _imageById(63), _imageById(635)]),
    Product(18, 30, "แก้วสีดำ I",
        [_imageById(431), _imageById(63), _imageById(635)]),
    Product(19, 30, "แก้วสีดำ II",
        [_imageById(490), _imageById(63), _imageById(635)]),
    Product(20, 30, "แก้วสีขาว",
        [_imageById(529), _imageById(63), _imageById(635)]),
    //  5 # 1070, 1071, 111, 133, 183 # 655, 670
    Product(21, 300000, "รถเก่า",
        [_imageById(1070), _imageById(655), _imageById(670)]),
    Product(22, 400000, "รถสีฟ้า",
        [_imageById(1071), _imageById(655), _imageById(670)]),
    Product(23, 350000, "รถสีดำ",
        [_imageById(111), _imageById(655), _imageById(670)]),
    Product(24, 700000, "รถสีแดง",
        [_imageById(133), _imageById(655), _imageById(670)]),
    Product(25, 800000, "รถ Van",
        [_imageById(183), _imageById(655), _imageById(670)]),
  ];

  static _imageById(int id) {
    return "https://picsum.photos/id/${id}/600/400.jpg";
  }

  late Map<Category, List<Product>> _productList;

  MockAPI() {
    _productList = {
      _catList[0]: _productData.sublist(0, 5),
      _catList[1]: _productData.sublist(5, 10),
      _catList[2]: _productData.sublist(10, 15),
      _catList[3]: _productData.sublist(15, 20),
      _catList[4]: _productData.sublist(20, 25)
    };
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
