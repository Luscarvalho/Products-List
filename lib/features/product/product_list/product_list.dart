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
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                if (_controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.error != null) {
                  return ProductError(
                    loadProducts: _controller.loadProducts,
                  );
                }

                if (_controller.products.isEmpty) {
                  return const ProductEmpty();
                }

                return ProductList(
                  products: _controller.products,
                  onToggleFavorite: _controller.toggleFavorite,
                  isFavorite: _controller.isFavorite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
