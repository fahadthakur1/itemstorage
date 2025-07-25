class Item {
  final String id;
  final String itemName;
  final bool isFavorite;

  const Item({
    required this.id,
    required this.itemName,
    this.isFavorite = false,
  });

  Item copyWith({String? id, String? itemName, bool? isFavorite}) {
    return Item(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'itemName': itemName, 'isFavorite': isFavorite};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      itemName: map['itemName'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
