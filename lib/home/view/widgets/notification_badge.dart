import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    super.key,
    required this.child,
    this.showNotificationBadge = false,
  });

  final Widget child;
  final bool showNotificationBadge;

  @override
  Widget build(BuildContext context) {
    final count = context.watch<BadgeNotificationsCubit>().state;
    if (!showNotificationBadge || count <= 0) return child;

    return Stack(
      children: [child, _CircleBadge(count: count)],
    );
  }
}

class _CircleBadge extends StatelessWidget {
  const _CircleBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: Dimens.paddingMediumSmall,
        height: Dimens.paddingMediumSmall,
        decoration: BoxDecoration(
          color: const Color(0xffC50022),
          borderRadius: BorderRadius.circular(Dimens.paddingXLarge),
        ),
        child: _NumberCount(count: count),
      ),
    );
  }
}

class _NumberCount extends StatelessWidget {
  const _NumberCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        count <= 9 ? count.toString() : '9+',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ).padded(const EdgeInsets.all(1)),
    );
  }
}
