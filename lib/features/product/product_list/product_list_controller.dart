import 'package:flulu/data/repositories/product/product_repository_interface.dart';
import 'package:flulu/data/services/product/product_service_interface.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductListController {
  final IProductRepository _repository;
  final IProductService _favoritesService;

  final ValueNotifier<List<ProductModel>> allProducts =
      ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<List<ProductModel>> filteredProducts =
      ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> error = ValueNotifier<String?>(null);
  final ValueNotifier<String> searchQuery = ValueNotifier<String>('');

  ProductListController({
    required IProductRepository repository,
    required IProductService favoritesService,
  })  : _repository = repository,
        _favoritesService = favoritesService;

  ValueNotifier<List<ProductModel>> get favoritesNotifier =>
      _favoritesService.favorites;

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      error.value = null;

      final products = await _repository.getProducts();
      allProducts.value = products;
      _filterProducts();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query.toLowerCase();
    _filterProducts();
  }

  void _filterProducts() {
    final query = searchQuery.value;
    final products = allProducts.value;

    if (query.isEmpty) {
      filteredProducts.value = products.toList();
    } else {
      filteredProducts.value = products
          .where((product) =>
              product.title.toLowerCase().contains(query) ||
              product.description.toLowerCase().contains(query))
          .toList();
    }
  }

  bool isFavorite(int id) => _favoritesService.isFavorite(id);

  Future<void> loadFavorites() async {
    await _favoritesService.loadFavorites();
  }

  Future<void> toggleFavorite(ProductModel product) async {
    await _favoritesService.toggleFavorite(product);
  }
}
