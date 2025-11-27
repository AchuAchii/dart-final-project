import 'contribution.dart';

class Goal {
  final String id;
  final String title;
  final String description;
  final double targetAmount;
  double currentAmount;
  final List<Contribution> contributions;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAmount,
    this.currentAmount = 0.0,
    List<Contribution>? contributions,
  }) : contributions = contributions ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'contributions': contributions.map((c) => c.toJson()).toList(),
    };
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    var contributionsList = json['contributions'] as List;
    List<Contribution> contributions = contributionsList.map((i) => Contribution.fromJson(i)).toList();

    return Goal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      targetAmount: json['targetAmount'],
      currentAmount: json['currentAmount'],
      contributions: contributions,
    );
  }

  void addContribution(Contribution contribution) {
    contributions.add(contribution);
    currentAmount += contribution.amount;
  }

  double get progress => (currentAmount / targetAmount).clamp(0.0, 1.0);
}
