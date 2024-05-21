import 'package:shopping_cart/model/cart_item.dart';
import 'package:shopping_cart/model/product_items.dart';
import 'package:online_sale_client/models/models.dart';

List<CartItem> items = [];
void addToCart(Inventory product, Batch batch) {
  for (var item in items) {
    if (item.batch.id == batch.id) {
      item.quantity += 1;
      return;
    }
  }
  items.add(CartItem(product: product, batch: batch, quantity: 1));
}

void removeFromCart(int batchId) {
  items.removeWhere((item) => item.batch.id == batchId);
}

// int getCartQuantity(int productId) {
//   for (var item in items) {
//     if (item.product.id == productId) {
//       return item.quantity;
//     }
//   }
//   return 0;
// }

double getTotalPrice() {
  return items.fold(0.0, (previousValue, element) => previousValue + element.subtotal);
}

String formatCurrency(double amount) {
  String amountStr = amount.floor().toString();
  int len = amountStr.length;

  if (len > 3) {
    amountStr =
        '${amountStr.substring(0, len - 3).replaceAllMapped(RegExp(r'\B(?=(\d{2})+(?!\d))'), (Match m) => ',' + m.group(0)!)},${amountStr.substring(len - 3)}';
  }

  return amountStr;
}
