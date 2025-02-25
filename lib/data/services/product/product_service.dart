import 'package:flulu/data/repositories/product/product_local_repository_interface.dart';
import 'package:flulu/data/services/product/product_service_interface.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductService implements IProductService {
  final IProductLocalRepository _localRepository;
  final ValueNotifier<List<ProductModel>> _favorites = ValueNotifier([]);

  ProductService({
    required IProductLocalRepository localRepository,
  }) : _localRepository = localRepository;

  @override
  ValueNotifier<List<ProductModel>> get favorites => _favorites;

  @override
  bool isFavorite(int id) =>
      _favorites.value.any((product) => product.id == id);

  @override
  Future<void> loadFavorites() async {
    final favoritesList = await _localRepository.getFavorites();
    _favorites.value = favoritesList.toList();
  }

  @override
  Future<void> toggleFavorite(ProductModel product) async {
    final currentFavorites = favorites.value.toList();

    if (isFavorite(product.id)) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    await _localRepository.saveFavorites(currentFavorites);

    _favorites.value = currentFavorites;
  }
}
