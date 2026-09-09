import 'package:flowee_app/models/flower.dart';
import 'package:flowee_app/state/favorites_controller.dart';
import 'package:flowee_app/theme/app_theme.dart';
import 'package:flowee_app/widgets/circle_icon_button.dart';
import 'package:flowee_app/widgets/flower_images.dart';
import 'package:flutter/material.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.flower, required this.onBack});

  final Flower flower;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'flower-image-${flower.id}',
              child: FlowerNetworkImages(
                imageUrl: flower.imageUrl,
                fallbackIcon: flower.icon,
                fallbackColor: flower.color,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: onBack,
                  ),
                  _FavoriteButton(flowerId: flower.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.flowerId});

  final String flowerId;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: FavoritesController.instance,
      builder: (context, favoritesId, _) {
        final isFavorite = favoritesId.contains(flowerId);
        return CircleIconButton(
          icon: isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          iconColor: isFavorite ? AppTheme.primary : Colors.black87,
          onTap: () => FavoritesController.instance.toggle(flowerId),
        );
      },
    );
  }
}
