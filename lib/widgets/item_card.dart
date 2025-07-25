import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../presentation/dialogs/add_item_dialog.dart';

/// A card widget that displays an item with its name and a favorite toggle button
///
/// The favorite button shows as:
/// - Red filled heart when the item is marked as favorite
/// - Outlined heart when the item is not a favorite
class ItemCard extends StatelessWidget {
  /// The item to display in this card
  final Item item;

  /// Callback function called when the favorite button is tapped
  /// Receives the updated favorite status (true/false)
  final Function(bool isFavorite)? onFavoriteToggle;

  /// Optional callback when the card itself is tapped
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.item,
    this.onFavoriteToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Adds subtle shadow and rounded corners
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        // Makes the card tappable with ripple effect
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Item name takes up most of the space
              Expanded(
                child: Text(
                  item.itemName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  // Handle long text gracefully
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Update/Edit button
              IconButton(
                onPressed: () {
                  // Open AddItemDialog for editing
                  showDialog(
                    context: context,
                    builder: (context) => AddItemDialog(item: item),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
                tooltip: 'Edit item',
              ),

              // Favorite toggle button
              IconButton(
                onPressed: () {
                  // Toggle the favorite status and call the callback
                  onFavoriteToggle?.call(!item.isFavorite);
                },
                icon: Icon(
                  // Show filled heart if favorite, outlined heart if not
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorite
                      ? Colors
                            .red // Red when favorite
                      : Colors.grey, // Grey outline when not favorite
                ),
                // Add tooltip for accessibility
                tooltip: item.isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
