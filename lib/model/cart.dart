import 'package:shopping_cart/model/cart_items.dart';
import 'package:shopping_cart/model/product_items.dart';

List<CartItem> items = [];
void addToCart(Product product) {
  for (var item in items) {
    if (item.product.id == product.id) {
      item.quantity += 1;
      return;
    }
  }
  items.add(CartItem(product: product, quantity: 1));
}

void removeFromCart(String productId) {
  items.removeWhere((item) => item.product.id == productId);
}

int getCartQuantity(String productId) {
  for (var item in items) {
    if (item.product.id == productId) {
      return item.quantity;
    }
  }
  return 0;
}
