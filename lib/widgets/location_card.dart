import 'package:flutter/material.dart';
import 'package:rapidoclone/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const LocationCard({
    Key? key,
    required this.location,
    this.onTap,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.address,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                location.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: location.isFavorite 
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              onPressed: onFavoriteTap,
            ),
          ],
        ),
      ),
    );
  }
}
