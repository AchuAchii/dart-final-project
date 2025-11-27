import 'package:flutter/foundation.dart';
import '../models/quote_model.dart';
import '../services/api_service.dart';

class QuoteProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  QuoteModel? _currentQuote;
  bool _isLoading = false;
  String? _errorMessage;

  QuoteModel? get currentQuote => _currentQuote;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetch a random quote
  Future<void> fetchQuote() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentQuote = await _apiService.fetchDailyQuote();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load quote: ${e.toString()}';
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Initialize with a quote
  Future<void> initialize() async {
    await fetchQuote();
  }
}
