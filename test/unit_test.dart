import 'package:test/test.dart';
import 'package:community_savings/models/goal.dart';
import 'package:community_savings/models/contribution.dart';

void main() {
  group('Goal', () {
    test('should calculate progress correctly', () {
      final goal = Goal(
        id: '1',
        title: 'Test Goal',
        description: 'Test',
        targetAmount: 1000,
      );

      expect(goal.progress, 0.0);

      goal.addContribution(Contribution(
        id: 'c1',
        contributorName: 'User',
        amount: 500,
        date: DateTime.now(),
      ));

      expect(goal.progress, 0.5);
      expect(goal.currentAmount, 500.0);
    });
  });
}
