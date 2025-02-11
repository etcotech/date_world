import 'package:date_world/features/cart/domain/models/cart_model.dart';
import 'package:date_world/features/product/domain/models/product_model.dart';
import 'package:date_world/interface/repo_interface.dart';

abstract class CartRepositoryInterface<T> implements RepositoryInterface{

  Future<dynamic> addToCartListData(CartModelBody cart, List<ChoiceOptions> choiceOptions, List<int>? variationIndexes, int buyNow, int? shippingMethodExist, int? shippingMethodId);

  Future<dynamic> updateQuantity(int? key,int quantity);

  Future<dynamic> addRemoveCartSelectedItem(Map<String, dynamic> data);

  Future<dynamic> restockRequest(CartModelBody cart, List<ChoiceOptions> choiceOptions, List<int>? variationIndexes, int buyNow, int? shippingMethodExist, int? shippingMethodId);

}