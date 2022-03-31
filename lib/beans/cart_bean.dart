class CartBean {
  int productId;
  String name;
  int price;
  int itemCount;
  String imgURL;

  CartBean(this.productId, this.name, this.price, this.itemCount, this.imgURL);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartBean &&
          runtimeType == other.runtimeType &&
          productId == other.productId;

  @override
  int get hashCode => productId.hashCode;

  @override
  String toString() {
    return 'CartBean{productId: $productId, name: $name, price: $price, itemCount: $itemCount}';
  }
}
