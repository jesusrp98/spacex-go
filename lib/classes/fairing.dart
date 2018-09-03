/// FAIRING CLASS
/// This class represent a detailed fairing, including the recovery process.
class Fairing {
  final bool reused;
  final bool recoveryAttempt;
  final bool recoverySuccess;
  final String ship;

  Fairing({
    this.reused,
    this.recoveryAttempt,
    this.recoverySuccess,
    this.ship,
  });

  factory Fairing.fromJson(Map<String, dynamic> json) {
    return Fairing(
      reused: json['reused'],
      recoveryAttempt: json['recovery_attempt'],
      recoverySuccess: json['recovered'],
      ship: json['ship'],
    );
  }
}
