import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quote.dart';

part 'quotes_api.g.dart';

@RestApi(baseUrl: "https://zenquotes.io/api")
abstract class QuotesApi {
  factory QuotesApi(Dio dio, {String baseUrl}) = _QuotesApi;

  @GET("/quotes")
  Future<List<Quote>> getQuotes();
}
