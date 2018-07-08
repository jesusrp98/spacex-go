class DragonDetails {
  final String name;
  final String serial;
  final String status;
  final DateTime firstLaunched;
  final List<String> missions;
  final int landings;
  final String details;

  DragonDetails(
      {this.name,
      this.serial,
      this.status,
      this.firstLaunched,
      this.missions,
      this.landings,
      this.details});

  factory DragonDetails.fromJson(Map<String, dynamic> json) {
    return DragonDetails(
      name: json['type'],
      serial: json['capsule_serial'],
      status: json['status'],
      firstLaunched: DateTime
          .fromMillisecondsSinceEpoch(json['original_launch_unix'] * 1000),
      missions: (json['missions'] as List),
      landings: json['landings'],
      details: json['details'],
    );
  }
}
