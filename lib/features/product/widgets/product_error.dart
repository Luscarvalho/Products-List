import 'package:flutter/material.dart';

class ProductError extends StatelessWidget {
  const ProductError({
    super.key,
    required this.loadProducts,
  });

  final VoidCallback loadProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no_connection.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const Text(
                  'Sem conexão!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            onPressed: loadProducts,
            child: const Text(
              'Tentar novamente',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
