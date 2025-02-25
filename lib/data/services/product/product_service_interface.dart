import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flutter/material.dart';

abstract class IProductService {
  ValueNotifier<List<ProductModel>> get favorites;
  bool isFavorite(int id);
  Future<void> loadFavorites();
  Future<void> toggleFavorite(ProductModel product);
}
