import 'package:shopping_cart/model/product_items.dart';

// class CartItems {
//   Product? product;
//   int? quantity;
//   CartItems({this.product, this.quantity=0});
//   double get subtotal {
//     if (product?.price != null && quantity != null) {
//       return product!.price * quantity!;
//     } else {
//       return 0.0; // or throw an exception or handle this case as needed
//     }
// }
// }

class CartItem{
  Product product;
  int quantity;
  CartItem({required this.product,required this.quantity});
  double get subtotal => product.price * quantity;
}