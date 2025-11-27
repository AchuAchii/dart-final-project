class Contribution {
  final String id;
  final String contributorName;
  final double amount;
  final DateTime date;

  Contribution({
    required this.id,
    required this.contributorName,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contributorName': contributorName,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory Contribution.fromJson(Map<String, dynamic> json) {
    return Contribution(
      id: json['id'],
      contributorName: json['contributorName'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
