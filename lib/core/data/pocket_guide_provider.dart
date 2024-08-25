import 'package:dio/dio.dart';
import 'package:pocket_guide/core/core.dart';

// TODO(someone): refactor the endpoint when api is ready
class PocketGuideProvider {
  PocketGuideProvider({required Dio client}) {
    _client = client;
  }

  late final Dio _client;

  Future<Response<String>> getProductPortfolio() async {
    final response = await _client.get<String>(
      PocketGuideEndpoints.productPortfolioURL,
    );

    return response;
  }
}
