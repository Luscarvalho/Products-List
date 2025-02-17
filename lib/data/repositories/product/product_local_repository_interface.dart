import 'package:flulu/domain/models/product/product_model.dart';

abstract class IProductLocalRepository {
  Future<List<ProductModel>> getFavorites();
  Future<void> saveFavorites(List<ProductModel> favorites);
}
