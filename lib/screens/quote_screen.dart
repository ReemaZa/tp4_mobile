import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quotes_service.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key, this.fromIntro = false});
  final bool fromIntro;

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteService service = QuoteService();

  List<Quote> _allQuotes = [];
  int _visibleCount = 5;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    final quotes = await service.fetchQuotes();
    setState(() {
      _allQuotes = quotes;
      _isLoading = false;
    });
  }

  void _loadMore() {
    setState(() {
      _visibleCount += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              if (widget.fromIntro) {
                //  on vient de l'intro → on affiche la navbar complète
                Navigator.pushReplacementNamed(context, '/bottomNav');
              } else {
                //  on vient déjà d'une navbar
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _visibleCount > _allQuotes.length
                  ? _allQuotes.length
                  : _visibleCount,
              itemBuilder: (context, index) {
                final quote = _allQuotes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      quote.text,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text(
                      quote.author,
                      textAlign: TextAlign.right,
                    ),
                  ),
                );
              },
            ),
          ),

          //  Bouton Load More
          if (_visibleCount < _allQuotes.length)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: _loadMore,
                child: const Text('Load more'),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'No more quotes available',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
