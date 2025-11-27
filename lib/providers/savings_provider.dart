import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/goal.dart';
import '../models/contribution.dart';

class SavingsProvider with ChangeNotifier {
  List<Goal> _goals = [];

  List<Goal> get goals => List.unmodifiable(_goals);

  SavingsProvider() {
    loadGoals();
  }

  Future<void> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String? goalsJson = prefs.getString('goals');
    if (goalsJson != null) {
      final List<dynamic> decodedList = jsonDecode(goalsJson);
      _goals = decodedList.map((item) => Goal.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(_goals.map((g) => g.toJson()).toList());
    await prefs.setString('goals', encodedList);
  }

  void addGoal(String title, String description, double targetAmount) {
    final newGoal = Goal(
      id: const Uuid().v4(),
      title: title,
      description: description,
      targetAmount: targetAmount,
    );
    _goals.add(newGoal);
    saveGoals();
    notifyListeners();
  }

  void contributeToGoal(String goalId, String contributorName, double amount) {
    final goalIndex = _goals.indexWhere((g) => g.id == goalId);
    if (goalIndex != -1) {
      final contribution = Contribution(
        id: const Uuid().v4(),
        contributorName: contributorName,
        amount: amount,
        date: DateTime.now(),
      );
      _goals[goalIndex].addContribution(contribution);
      saveGoals();
      notifyListeners();
    }
  }
}
