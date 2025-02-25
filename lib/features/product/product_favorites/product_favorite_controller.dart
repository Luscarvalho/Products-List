import 'package:flulu/data/services/product/product_service_interface.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductFavoritesController {
  final IProductService _favoritesService;

  ProductFavoritesController({
    required IProductService favoritesService,
  }) : _favoritesService = favoritesService;

  ValueNotifier<List<ProductModel>> get favorites =>
      _favoritesService.favorites;

  bool isFavorite(int id) => _favoritesService.isFavorite(id);

  Future<void> toggleFavorite(ProductModel product) async {
    await _favoritesService.toggleFavorite(product);
  }
}
