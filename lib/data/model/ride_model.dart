class RideModel {
  final String id;
  final String source;
  final String destination;
  final double distance;
  final double fare;
  final String status;
  final DateTime createdAt;

  RideModel({
    required this.id,
    required this.source,
    required this.destination,
    required this.distance,
    required this.fare,
    required this.status,
    required this.createdAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      source: json['source'],
      destination: json['destination'],
      distance: (json['distance'] as num).toDouble(),
      fare: (json['fare'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'destination': destination,
      'distance': distance,
      'fare': fare,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
