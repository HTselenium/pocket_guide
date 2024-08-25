import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pocket_guide/news/news.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required NewsUsecases newsUsecases}) : super(NewsInitial()) {
    _newsUsecases = newsUsecases;

    on<NewsStarted>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await _newsUsecases.getAllNews();
        emit(NewsSuccess(news: news));
      } catch (e) {
        emit(NewsFailure(error: e));
      }
    });

    add(NewsStarted());
  }

  late final NewsUsecases _newsUsecases;
}
