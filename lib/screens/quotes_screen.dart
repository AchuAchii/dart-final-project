import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuoteProvider>(context, listen: false).fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Daily Inspiration', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Consumer<QuoteProvider>(
            builder: (context, quoteProvider, _) {
              return IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: quoteProvider.isLoading
                    ? null
                    : () => quoteProvider.fetchQuote(),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00C853), Color(0xFF2962FF)],
          ),
        ),
        child: Consumer<QuoteProvider>(
          builder: (context, quoteProvider, _) {
            if (quoteProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }

            if (quoteProvider.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 64, color: Colors.white70),
                      const SizedBox(height: 16),
                      Text(
                        quoteProvider.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => quoteProvider.fetchQuote(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF00C853),
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final quote = quoteProvider.currentQuote;
            if (quote == null) return const SizedBox();

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.format_quote_rounded, size: 60, color: Colors.white70),
                          const SizedBox(height: 24),
                          Text(
                            quote.content,
                            style: const TextStyle(
                              fontSize: 28,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Georgia',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          Container(
                            height: 2,
                            width: 60,
                            color: Colors.white54,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            quote.author,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Quotes provided by AdviceSlip API',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
