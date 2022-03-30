class Category {
  int _id;
  String _title;
  String _imgURL;

  Category(this._id, this._title, this._imgURL);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get imgURL => _imgURL;

  set imgURL(String value) {
    _imgURL = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && _id == other._id;

  @override
  int get hashCode => _id.hashCode;
}

class Product {
  int _id;
  String _name;
  int _price;
  List<String> _imgURL;

  Product(this._id, this._price, this._name, this._imgURL);

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  List<String> get imgURL => _imgURL;

  set imgURL(List<String> value) {
    _imgURL = value;
  }
}
