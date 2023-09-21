import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tz_id;
  final int localtime_epoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz_id,
    required this.localtime_epoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tz_id: json['tz_id'],
      localtime_epoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }

  factory Location.empty() {
    return Location(
      name: '',
      region: '',
      country: '',
      lat: 0.0,
      lon: 0.0,
      tz_id: '',
      localtime_epoch: 0,
      localtime: '',
    );
  }

  @override
  List<Object?> get props => [
        name,
        region,
        country,
        lat,
        lon,
        tz_id,
        localtime_epoch,
        localtime,
      ];
}
