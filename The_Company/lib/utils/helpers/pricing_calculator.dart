class PricingCalculator {
  /// __ Calculate Price based on tez and shipping

  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = taxAmount + shippingCost + productPrice;
    return totalPrice;
  }

  /// __ calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// __ calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // we can use tax rate api also for return tax value according to location
    // or we can calculate it
    return 0.10;
  }

  static double getShippingCost(String location) {
    // we can use shipping rate api also for return shipping rate value according to location
    // or we can calculate it
    return 5.00;
  }

  // sum all cart values and return total amount

  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0,
  //       (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
