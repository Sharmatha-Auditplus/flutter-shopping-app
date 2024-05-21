import 'package:shopping_cart/pages/checkout_page.dart';

OrderSummary globalOrderSummary = OrderSummary();

class OrderSummary {
  static DeliveryMethod? deliveryMethod;
  static Map<String, String?>? deliveryAddress;
  
}
