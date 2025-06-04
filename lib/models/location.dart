class Location {
  final String id;
  final String name;
  final String address;
  final bool isFavorite;
  final DateTime timestamp;

  Location({
    required this.id,
    required this.name,
    required this.address,
    this.isFavorite = false,
    required this.timestamp,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      isFavorite: json['isFavorite'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'isFavorite': isFavorite,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
