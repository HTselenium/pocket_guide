import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/error/error.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/news/news.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We get rid of notifications when we enter the page
    context.read<BadgeNotificationsCubit>().clearNotifications();

    return Provider(
      create: (context) => NewsUsecases(
        context.read<NewsProviderRepository>(),
      ),
      child: BlocProvider(
        create: (context) => NewsBloc(
          newsUsecases: context.read<NewsUsecases>(),
        ),
        child: layout(),
      ),
    );
  }

  Widget layout() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final height = MediaQuery.of(context).size.height * .6;

        Widget layout() {
          if (state is NewsLoading || state is NewsInitial) {
            return loadingLayout(height);
          } else if (state is NewsSuccess) {
            return successLayout(context, state.news);
          } else if (state is NewsFailure) {
            return ErrorPage(
              error: state.error,
              onRetry: () {
                context.read<NewsBloc>().add(NewsStarted());
              },
            );
          } else {
            return const Center(child: Text('error'));
          }
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: layout(),
        );
      },
    );
  }

  Widget successLayout(BuildContext context, List<News> news) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: false,
            title: 'News & Articles',
            onPressed: () {},
            isNewsList: true,
          ),
        // TODO(someone): use it when we have the content
        //  const SliverToBoxAdapter(child: CategorySelector()),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(news.length, (i) {
                return NewsCard(
                  news: news[i],
                  number: i + 1,
                ).padded(AppTheme.defaultScreenPadding);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingLayout(double height) {
    return SizedBox(
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
