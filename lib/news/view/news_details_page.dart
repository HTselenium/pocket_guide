import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/news/news.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({
    super.key,
    required this.id,
    required this.news,
  });

  final String id;
  final News news;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final date = DateTime.parse(news.timestamp),
        dateFormat = DateFormat.yMMMMd('en_US');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              background: ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: NewsImage(
                        imageUrl: news.asset.url.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x00000000),
                            Color(0xff000000),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacer.medium(),
                        IconButton(
                          icon: Icon(
                            Icons.adaptive.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => context.go('/news'),
                        ),
                        Text(
                          dateFormat.format(date),
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: Colors.white54),
                        ),
                        Text(
                          news.title,
                          style: theme.textTheme.headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          news.description,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white54),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: news.category.color!),
                            enableFeedback: false,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () {}, // TODO(someone): implement
                          child: Text(
                            news.category.categoryName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ].joinWith(VerticalSpacer.mediumSmall()),
                    ).padded(AppTheme.defaultScreenPadding),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentfulRichText(news.content).documentToWidgetTree.padded(
                  AppTheme.defaultScreenPadding
                      .copyWith(bottom: Dimens.paddingXXLarge),
                ),
          ),
        ],
      ),
    );
  }
}
