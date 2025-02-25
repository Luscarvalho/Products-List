import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/features/product/widgets/product_empty.dart';
import 'package:flulu/features/product/widgets/product_error.dart';
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
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ValueListenableBuilder(
            valueListenable: _controller.error,
            builder: (context, error, child) {
              if (error != null) {
                return ProductError(loadProducts: _controller.loadProducts);
              }
              return Column(
                children: [
                  _buildSearchField(),
                  _buildProductList(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  ProductSearchField _buildSearchField() {
    return ProductSearchField(
      controller: _searchController,
      onSearch: _controller.searchProducts,
      onClear: () {
        _searchController.clear();
        _controller.searchProducts('');
      },
    );
  }

  Expanded _buildProductList() {
    return Expanded(
      child: ValueListenableBuilder<List<ProductModel>>(
        valueListenable: _controller.filteredProducts,
        builder: (context, products, child) {
          if (products.isEmpty) {
            return const ProductEmpty();
          }
          return ValueListenableBuilder<List<ProductModel>>(
            valueListenable: _controller.favoritesNotifier,
            builder: (context, favorites, child) {
              return ProductList(
                products: products,
                onToggleFavorite: _controller.toggleFavorite,
                isFavorite: _controller.isFavorite,
              );
            },
          );
        },
      ),
    );
  }
}
