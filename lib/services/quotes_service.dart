import 'package:dio/dio.dart';
import 'quotes_api.dart';
import '../models/quote.dart';

class QuoteService {
  late QuotesApi api;

  QuoteService() {
    final dio = Dio();
    api = QuotesApi(dio);
  }

  Future<List<Quote>> fetchQuotes() {
    return api.getQuotes();
  }
}
