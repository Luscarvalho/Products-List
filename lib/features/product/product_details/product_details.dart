import 'package:flulu/domain/models/product/product_model.dart';
import 'package:flulu/features/product/product_details/product_detail_controller.dart';
import 'package:flulu/features/product/widgets/app_bar_product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I<ProductDetailsController>();
    return Scaffold(
      appBar: AppBarProduct(
        title: 'Detalhes do Produto',
        actions: [
          ValueListenableBuilder<List<ProductModel>>(
            valueListenable: controller.favoritesNotifier,
            builder: (context, _, __) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    controller.isFavorite(product.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isFavorite(product.id)
                        ? Colors.red
                        : Colors.grey[800],
                  ),
                  onPressed: () => controller.toggleFavorite(product),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero(
            //   tag: 'product-${product.id}',
            //   child: Image.network(
            //     product.image,
            //     width: double.infinity,
            //     height: 300,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            ' ${product.rating.rate} (${product.rating.count} avaliações)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'R\$ ${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.sort),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.menu),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
