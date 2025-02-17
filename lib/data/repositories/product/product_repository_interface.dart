import 'package:flulu/domain/models/product/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
}
