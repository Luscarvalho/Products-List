import 'package:flulu/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarProduct extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProduct({
    required this.title,
    this.actions,
    super.key,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: false,
      actions: actions ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () => context.go(Routes.favorites),
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => FavoritesPage(
                //         controller: controller,
                //       ),
                //     ),
                //   );
                // },
              ),
            ),
          ],
      forceMaterialTransparency: true,
    );
  }
}
