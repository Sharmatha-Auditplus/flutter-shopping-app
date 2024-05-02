import 'package:shopping_cart/model/product_items.dart';
import 'package:online_sale_client/models/models.dart';

class CartItem {
  Inventory product;
  Batch batch;
  int quantity;
  CartItem({required this.product, required this.batch, required this.quantity});
  num get subtotal => batch.rate! * quantity;
}
