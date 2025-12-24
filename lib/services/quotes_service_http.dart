import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  static const String url = 'https://zenquotes.io/api/quotes';

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Quote.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
