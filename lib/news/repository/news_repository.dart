import 'package:contentful/contentful.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pocket_guide/contentful/contentful.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/news/news.dart';

abstract class INewsRepository {
  Future<List<News>> getNewsList({int? limit});

  Future<News?> getNews({required String id});
}

class NewsProviderRepository implements INewsRepository {
  NewsProviderRepository({required this.cmsClient});

  late final Client cmsClient;

  @override
  Future<List<News>> getNewsList({int? limit}) async {
    final limitedRequest = NewsRequestDTO(
      limit: limit?.toString(),
    );

    final unlimitedRequest = NewsRequestDTO();
    try {
      final response = await cmsClient.getEntries<CMSEntryDTO<NewsDTO>>(
        limit != null ? limitedRequest.toJson() : unlimitedRequest.toJson(),
        CMSEntryDTO.fromJsonWithParser(
          NewsDTO.fromJson,
        ),
      );

      if (response.items.isEmpty) {
        throw Exception('Could not retrieve any news');
      }

      return response.items
          .map((newsDto) => newsDto.fields!.toModel(newsDto.sys!.id))
          .toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw AppException.fromDio(e);
    }
  }

  @override
  Future<News?> getNews({required String id}) async {
    final allNews = await getNewsList();
    final news = allNews.firstWhere((element) => element.id == id);

    final index = allNews.indexWhere((element) => element.id == id);
    return news.copyWith(number: index + 1);
  }
}
