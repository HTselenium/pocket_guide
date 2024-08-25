import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';

class LegalFooter extends StatelessWidget {
  const LegalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(AppRoutes.legalPages.length, (index) {
          final route = AppRoutes.legalPages[index];

          return _CustomLegalPageButton(
            text: route.localeTitle(context),
            route: route,
          );
        }),
        _CustomLegalPageButton(
          text: l10n.dataPrivacy,
          route: AppRoutes.dataPrivacy,
        ),
        _CustomLegalPageButton(
          text: l10n.termsOfUse,
          route: AppRoutes.termsOfUse,
        ),
      ].joinWith(
        const Text('|', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class _CustomLegalPageButton extends StatelessWidget {
  const _CustomLegalPageButton({
    required this.text,
    required this.route,
  });

  final String text;
  final AppRoutes route;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.grey),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: () => context.push(route.path),
      ),
    );
  }
}
