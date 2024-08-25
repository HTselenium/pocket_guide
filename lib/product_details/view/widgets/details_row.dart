import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _DetailsRowFrame(
      titleChild: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          color: const Color(AppTheme.greyColor),
          fontWeight: FontWeight.w400,
        ),
      ),
      valueChild: Text(
        value,
        style: theme.textTheme.titleSmall!.copyWith(
          color: AppTheme.darkTextColor(theme),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class DetailsTitleRow extends StatelessWidget {
  const DetailsTitleRow({
    super.key,
    required this.title,
    required this.value,
    this.value2,
  });

  final String title;
  final String value;
  final String? value2;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _DetailsRowFrame(
      titleChild: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          color: AppTheme.darkTextColor(theme),
          fontWeight: FontWeight.w700,
        ),
      ),
      valueChild: Text(
        value,
        style: theme.textTheme.titleSmall!.copyWith(
          color: AppTheme.darkTextColor(theme),
          fontWeight: FontWeight.w700,
        ),
      ),
      value2Child: value2 != null
          ? Text(
              value2!,
              style: theme.textTheme.titleSmall!.copyWith(
                color: AppTheme.darkTextColor(theme),
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
    );
  }
}

class DetailsIconRow extends StatelessWidget {
  const DetailsIconRow({
    super.key,
    required this.title,
    required this.value,
    this.value2,
  });

  final String title;
  final Widget value;
  final Widget? value2;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return _DetailsRowFrame(
      titleChild: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          color: const Color(AppTheme.greyColor),
          fontWeight: FontWeight.w400,
        ),
      ),
      valueChild: Align(alignment: Alignment.centerLeft, child: value),
      value2Child: value2 != null
          ? Align(alignment: Alignment.centerLeft, child: value2)
          : null,
    );
  }
}

class _DetailsRowFrame extends StatelessWidget {
  const _DetailsRowFrame({
    required this.titleChild,
    required this.valueChild,
    this.value2Child,
  });

  final Widget titleChild;
  final Widget valueChild;
  final Widget? value2Child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: titleChild),
        Expanded(child: valueChild),
        if (value2Child != null) Expanded(child: value2Child!),
      ].joinWith(HorizontalSpacer.semi()),
    );
  }
}
