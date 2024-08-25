import 'package:pocket_guide/news/news.dart';

class NewsUsecases {
  NewsUsecases(this.newsRepository);

  final INewsRepository newsRepository;

  Future<News?> getNewsById({required String id}) async {
    return newsRepository.getNews(id: id);
  }

  Future<List<News>> getAllNews() async {
    return newsRepository.getNewsList(limit: 50);
  }
}
