import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/savings_provider.dart';
import '../models/contribution.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savingsProvider = Provider.of<SavingsProvider>(context);
    
    // Collect all contributions from all goals
    final List<_TransactionItem> transactions = [];
    for (final goal in savingsProvider.goals) {
      for (final contribution in goal.contributions) {
        transactions.add(_TransactionItem(
          contribution: contribution,
          goalTitle: goal.title,
        ));
      }
    }
    
    // Sort by date (newest first)
    transactions.sort((a, b) => b.contribution.date.compareTo(a.contribution.date));
    
    // Calculate total
    final total = transactions.fold<double>(
      0.0,
      (sum, item) => sum + item.contribution.amount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Summary Card
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E7D32), Color(0xFF1565C0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Contributions',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '฿${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${transactions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Transactions List
                Expanded(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final item = transactions[index];
                      final dateFormat = DateFormat('MMM dd, yyyy • HH:mm');
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                            child: const Icon(
                              Icons.add_circle,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          title: Text(
                            item.goalTitle,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'By: ${item.contribution.contributorName}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                dateFormat.format(item.contribution.date),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '+฿${item.contribution.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _TransactionItem {
  final Contribution contribution;
  final String goalTitle;

  _TransactionItem({
    required this.contribution,
    required this.goalTitle,
  });
}
