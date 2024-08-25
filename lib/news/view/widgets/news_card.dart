import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/news/news.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
    this.number = 1,
  });

  final int number;
  final News news;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color =
        news.category.color == Colors.white ? Colors.grey : news.category.color;

    return InkWell(
      borderRadius: AppTheme.defaultBorderRadius,
      onTap: () {
        pianoFlutterPlugin.trackEvent('page.display', {
          'page': news.title,
          'page_chapter1': 'news',
        });
        context.push('/news/$number', extra: news);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: AppTheme.defaultBorderRadius,
              border: Border.all(
                color: color!.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _Image(imageUrl: news.asset.url.toString()),
                    _timePassed(),
                  ],
                ),
                VerticalSpacer.medium(),
                Text(
                  news.title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ).padded(
                  const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
                ),
                Text(
                  news.shortDescription,
                ).padded(
                  const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
                ),
                VerticalSpacer.medium(),
              ],
            ),
          ),
          _categoryIndicator(color),
        ],
      ),
    );
  }

  Widget _categoryIndicator(Color color) {
    return Positioned(
      left: 0,
      bottom: 33,
      child: Container(
        height: 25,
        width: 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppTheme.defaultBorderRadius,
        ),
      ),
    );
  }

  String timeAgo(String timestamp) {
    final currentDate = DateTime.now();
    final publishDate = DateTime.parse(timestamp);

    final different = currentDate.difference(publishDate);

    if (different.inDays > 365) {
      return '${(different.inDays / 365).floor()} '
          "${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    } else if (different.inDays > 30) {
      return '${(different.inDays / 30).floor()} '
          "${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    } else if (different.inDays > 7) {
      return '${(different.inDays / 7).floor()} '
          "${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    } else if (different.inDays > 0) {
      return '${different.inDays} '
          "${different.inDays == 1 ? "day" : "days"} ago";
    } else if (different.inHours > 0) {
      return '${different.inHours} '
          "${different.inHours == 1 ? "hour" : "hours"} ago";
    } else if (different.inMinutes > 0) {
      return '${different.inMinutes} '
          "${different.inMinutes == 1 ? "minute" : "minutes"} ago";
    } else if (different.inMinutes == 0) {
      return 'Just Now';
    }
    return different.toString();
  }

  Widget _timePassed() {
    // final publishDate = DateTime.parse(news.timestamp);
    // final diffTime = publishDate.difference(DateTime.now()).inMinutes.abs();
    // final timePassed = diffTime > 60
    //     ? '${diffTime ~/ 60}h ago'
    //     : '${diffTime < 1 ? '1' : diffTime}m ago';

    // We can add '$timePassed ago'
    // But in spanish it's 'hace $timePassed' for exampl, etc...
    return Row(
      children: [
        Assets.icons.clock.svg(
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        Text(
          timeAgo(news.timestamp),
          style: const TextStyle(color: Colors.white),
        ),
      ].joinWith(HorizontalSpacer.small()),
    ).padded(const EdgeInsets.all(Dimens.paddingMediumSmall));
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const height = 160.0;
    const width = double.maxFinite;
    const fit = BoxFit.cover;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: NewsImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
        _overlayGradient(),
      ],
    );
  }

  Widget _overlayGradient() {
    return Container(
      width: double.maxFinite,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          transform: const GradientRotation(-50),
          colors: [
            const Color(0xff000000).withOpacity(0.5),
            const Color(0xff000000).withOpacity(0),
          ],
          stops: const [0.0, 0.3],
        ),
      ),
    );
  }
}
