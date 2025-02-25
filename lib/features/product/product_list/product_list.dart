import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/features/product/widgets/product_search_field.dart';
import 'package:flulu/features/product/widgets/app_bar_product.dart';
import 'package:flulu/features/product/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'product_list_controller.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({
    super.key,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _searchController = TextEditingController();
  final _controller = GetIt.I<ProductListController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _controller.loadFavorites();
    await _controller.loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarProduct(
        title: 'Produtos',
      ),
      body: Column(
        children: [
          ProductSearchField(
            controller: _searchController,
            onSearch: _controller.searchProducts,
            onClear: () {
              _searchController.clear();
              _controller.searchProducts('');
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _controller.isLoadingNotifier,
            builder: (context, isLoading, child) {
              return isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink();
            },
          ),
          ValueListenableBuilder<String?>(
            valueListenable: _controller.errorNotifier,
            builder: (context, error, child) {
              return error != null
                  ? Text('Erro: $error',
                      style: const TextStyle(color: Colors.red))
                  : const SizedBox.shrink();
            },
          ),
          Expanded(
            child: ValueListenableBuilder<List<ProductModel>>(
              valueListenable: _controller.filteredProductsNotifier,
              builder: (context, value, child) {
                return ValueListenableBuilder<List<ProductModel>>(
                  valueListenable: _controller.favoritesNotifier,
                  builder: (context, favorites, child) {
                    return ProductList(
                      products: _controller.products,
                      onToggleFavorite: _controller.toggleFavorite,
                      isFavorite: _controller.isFavorite,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
