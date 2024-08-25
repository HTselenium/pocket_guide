import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/news/news.dart';

// TODO(someone): Filter news by category once it's finalized
class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(bottom: Dimens.paddingMedium20),
      child: ScrollConfiguration(
        // Needed for horizontal scroll to work on web
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: NewsCategory.all.length,
          itemBuilder: (context, index) {
            final theme = context.theme;
            final isInverted = NewsCategory.all[index].color == Colors.white;
            final child = Text(
              NewsCategory.all[index].localeTitle(context),
              style: TextStyle(
                color: isInverted
                    ? theme.isDark
                        ? Colors.white
                        : Colors.grey.shade700
                    : null,
              ),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.paddingDefault,
              ),
              child: isInverted
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: theme.isDark
                            ? const BorderSide(color: Colors.white)
                            : null,
                      ),
                      child: child,
                      onPressed: () {},
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NewsCategory.all[index].color,
                        elevation: 0,
                      ),
                      child: child,
                      onPressed: () {},
                    ),
            );
          },
        ),
      ),
    );
  }
}
