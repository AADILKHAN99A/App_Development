import 'package:the_company/database/models/cart_item.dart';

class Order {
  final Item item;
  final String tranId;

  Order(this.item, this.tranId);

  Order.fromMap(Map<String, dynamic> data)
      : item = data['item'],
        tranId = data['transId'];

  Map<String, dynamic> toMap() {
    return {'item': item, 'transId': tranId};
  }
}
