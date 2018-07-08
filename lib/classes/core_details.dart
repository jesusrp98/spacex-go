class CoreDetails {
  final String serial;
  final int block;
  final String status;
  final DateTime firstLaunched;
  final List<String> missions;
  final int landings;
  final String details;

  CoreDetails(
      {this.serial,
      this.block,
      this.status,
      this.firstLaunched,
      this.missions,
      this.landings,
      this.details});

  factory CoreDetails.fromJson(Map<String, dynamic> json) {
    return CoreDetails(
        serial: json['core_serial'],
        block: json['block'],
        status: json['status'],
        firstLaunched: DateTime
            .fromMillisecondsSinceEpoch(json['original_launch_unix'] * 1000),
        //TODO could fail
        missions: (json['missions'] as List),
        landings: json['rtls_landings'] + json['asds_landings'],
        details: json['details']);
  }
}
