import 'package:dio/dio.dart';
import '../model/ride_model.dart';

class RideRepository {
  final Dio _dio;

  RideRepository(this._dio);

  Future<List<RideModel>> getNearbyRides(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        '/rides/nearby',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      final List<dynamic> data = response.data;
      return data.map((json) => RideModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<RideModel> createRide(RideModel ride) async {
    try {
      final response = await _dio.post(
        '/rides',
        data: ride.toJson(),
      );
      return RideModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
