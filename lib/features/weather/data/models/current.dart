class Current {
  final int last_updated_epoch;
  final String last_updated;
  final double temp_c;
  final double temp_f;
  final int is_day;
  final Condition condition;
  final double wind_mph;
  final double wind_kph;
  final int wind_degree;
  final String wind_dir;
  final double pressure_mb;
  final double pressure_in;
  final double precip_mm;
  final double precip_in;
  final int humidity;
  final int cloud;
  final double feelslike_c;
  final double feelslike_f;
  final double vis_km;
  final double vis_miles;
  final double uv;
  final double gust_mph;
  final double gust_kph;

  Current({
    required this.last_updated_epoch,
    required this.last_updated,
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.condition,
    required this.wind_mph,
    required this.wind_kph,
    required this.wind_degree,
    required this.wind_dir,
    required this.pressure_mb,
    required this.pressure_in,
    required this.precip_mm,
    required this.precip_in,
    required this.humidity,
    required this.cloud,
    required this.feelslike_c,
    required this.feelslike_f,
    required this.vis_km,
    required this.vis_miles,
    required this.uv,
    required this.gust_mph,
    required this.gust_kph,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      last_updated_epoch: json['last_updated_epoch'],
      last_updated: json['last_updated'],
      temp_c: json['temp_c'].toDouble(),
      temp_f: json['temp_f'].toDouble(),
      is_day: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      wind_mph: json['wind_mph'].toDouble(),
      wind_kph: json['wind_kph'].toDouble(),
      wind_degree: json['wind_degree'],
      wind_dir: json['wind_dir'],
      pressure_mb: json['pressure_mb'].toDouble(),
      pressure_in: json['pressure_in'].toDouble(),
      precip_mm: json['precip_mm'].toDouble(),
      precip_in: json['precip_in'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslike_c: json['feelslike_c'].toDouble(),
      feelslike_f: json['feelslike_f'].toDouble(),
      vis_km: json['vis_km'].toDouble(),
      vis_miles: json['vis_miles'].toDouble(),
      uv: json['uv'],
      gust_mph: json['gust_mph'].toDouble(),
      gust_kph: json['gust_kph'].toDouble(),
    );
  }
  factory Current.empty() {
    return Current(
      last_updated_epoch: 0,
      last_updated: '',
      temp_c: 0.0,
      temp_f: 0.0,
      is_day: 0,
      condition: Condition.empty(),
      wind_mph: 0.0,
      wind_kph: 0.0,
      wind_degree: 0,
      wind_dir: '',
      pressure_mb: 0.0,
      pressure_in: 0.0,
      precip_mm: 0.0,
      precip_in: 0.0,
      humidity: 0,
      cloud: 0,
      feelslike_c: 0.0,
      feelslike_f: 0.0,
      vis_km: 0.0,
      vis_miles: 0.0,
      uv: 0,
      gust_mph: 0.0,
      gust_kph: 0.0,
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: 'https:${json['icon']}',
      code: json['code'],
    );
  }
  factory Condition.empty() {
    return Condition(
      text: '',
      icon: '',
      code: 0,
    );
  }
}
