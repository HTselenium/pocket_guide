part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsFailure extends NewsState {
  const NewsFailure({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}

class NewsSuccess extends NewsState {
  const NewsSuccess({required this.news});

  final List<News> news;

  @override
  List<Object> get props => [news];
}
