import 'package:flutter/material.dart';

class ProductEmpty extends StatelessWidget {
  const ProductEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty.png',
            width: 200,
          ),
          const Text(
            'Nenhum produto encontrado',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
