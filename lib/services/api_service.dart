import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class ApiService {
  // Primary API - Advice Slip
  static const String _baseUrl = 'https://api.adviceslip.com/advice';

  // Fallback quotes in case of API/CORS errors
  final List<QuoteModel> _fallbackQuotes = [
    QuoteModel(content: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
    QuoteModel(content: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
    QuoteModel(content: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
    QuoteModel(content: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
    QuoteModel(content: "You miss 100% of the shots you don't take.", author: "Wayne Gretzky"),
    QuoteModel(content: "Saving money is a good habit.", author: "Community Savings"),
    QuoteModel(content: "Small steps lead to big changes.", author: "Anonymous"),
  ];

  /// Fetch a random motivational quote
  Future<QuoteModel> fetchDailyQuote() async {
    try {
      // Add random query param to prevent caching
      final response = await http.get(
        Uri.parse('$_baseUrl?t=${DateTime.now().millisecondsSinceEpoch}'),
      ).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final slip = data['slip'];
        return QuoteModel(
          content: slip['advice'],
          author: 'Daily Advice', // API doesn't provide author
        );
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      // Fallback to local data on ANY error (CORS, offline, etc.)
      print('API Error: $e. Using fallback data.');
      return _fallbackQuotes[Random().nextInt(_fallbackQuotes.length)];
    }
  }

  /// Fetch multiple random quotes (Returns local list for stability)
  Future<List<QuoteModel>> fetchMultipleQuotes({int count = 5}) async {
    // Return shuffled fallback quotes
    final shuffled = List<QuoteModel>.from(_fallbackQuotes)..shuffle();
    return shuffled.take(count).toList();
  }
}


