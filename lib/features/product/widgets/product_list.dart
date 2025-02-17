import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.products,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final List<ProductModel> products;
  final Function(ProductModel) onToggleFavorite;
  final Function(int) isFavorite;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListItem(
          product: product,
          isFavorite: isFavorite(product.id),
          onToggleFavorite: () => onToggleFavorite(product),
        );
      },
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final ProductModel product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Hero(
      //   tag: 'product-${product.id}',
      //   child: Image.network(
      //     product.image,
      //     width: 50,
      //     height: 70,
      //     fit: BoxFit.cover,
      //     errorBuilder: (context, error, stackTrace) =>
      //         const Icon(Icons.error),
      //   ),
      // ),
      leading: Image.network(
        product.image,
        width: 50,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
      title: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                '${product.rating.rate} (${product.rating.count})',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'R\$ ${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.orange[900],
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey[800],
          ),
          onPressed: onToggleFavorite),
      onTap: () => context.push(Routes.productDetail, extra: product),
    );
  }
}
