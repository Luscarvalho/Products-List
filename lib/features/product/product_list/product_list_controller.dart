import 'package:flulu/data/repositories/product/product_repository_interface.dart';
import 'package:flulu/data/services/product/product_favorites_service.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/product/product_model.dart';

class ProductListController {
  final IProductRepository _repository;
  final FavoritesService _favoritesService;

  final ValueNotifier<List<ProductModel>> allProductsNotifier =
      ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<List<ProductModel>> filteredProductsNotifier =
      ValueNotifier<List<ProductModel>>([]);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  ProductListController({
    required IProductRepository repository,
    required FavoritesService favoritesService,
  })  : _repository = repository,
        _favoritesService = favoritesService;

  List<ProductModel> get products => filteredProductsNotifier.value;
  bool get isLoading => isLoadingNotifier.value;
  String? get error => errorNotifier.value;
  String get searchQuery => searchQueryNotifier.value;

  ValueNotifier<List<ProductModel>> get favoritesNotifier =>
      _favoritesService.favoritesNotifier;

  Future<void> loadProducts() async {
    try {
      isLoadingNotifier.value = true;
      errorNotifier.value = null;

      final products = await _repository.getProducts();
      allProductsNotifier.value = products;
      _filterProducts();
    } catch (e) {
      errorNotifier.value = e.toString();
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  void searchProducts(String query) {
    searchQueryNotifier.value = query.toLowerCase();
    _filterProducts();
  }

  void _filterProducts() {
    final query = searchQueryNotifier.value;
    final allProducts = allProductsNotifier.value;

    if (query.isEmpty) {
      filteredProductsNotifier.value = List.from(allProducts);
    } else {
      filteredProductsNotifier.value = allProducts
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
