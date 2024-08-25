import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/industry/cubit/industry_type_cubit.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/industry/models/industry_type_enum.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({
    super.key,
    required this.industryType,
  });

  final IndustryType industryType;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: _DashedLinePainter(theme.primaryColor),
          child: Container(height: 75),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            IndustryType.all.length,
            (index) => MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => {
                  context
                      .read<InitialLayoutCubit>()
                      .toogleIndustryLayout(index),
                  context
                      .read<InitialLayoutHydratedCubit>()
                      .updateIndustryTypeIndex(index),
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: IndustryType.all[index] == industryType ? 24 : 16,
                  width: IndustryType.all[index] == industryType ? 24 : 16,
                  decoration: IndustryType.all[index] == industryType
                      ? BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        )
                      : BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.primaryColor,
                          ),
                        ),
                ),
              ).padded(const EdgeInsets.only(bottom: 15)),
            ),
          ),
        ),
        _arrow(theme, context),
      ],
    );
  }

  Widget _arrow(ThemeData theme, BuildContext context) {
    final cubit = context.read<InitialLayoutCubit>();
    final state =
        context.read<InitialLayoutHydratedCubit>().state.industryTypeIndex;
    return Align(
      alignment: state == 1 ? Alignment.centerLeft : Alignment.centerRight,
      child: IconButton(
        color: theme.primaryColor,
        onPressed: () => {
          if (state == 1)
            context
                .read<InitialLayoutHydratedCubit>()
                .updateIndustryTypeIndex(0)
          else
            context
                .read<InitialLayoutHydratedCubit>()
                .updateIndustryTypeIndex(1),
          cubit.setIndustryType(
            IndustryType.all[context
                .read<InitialLayoutHydratedCubit>()
                .state
                .industryTypeIndex],
          ),
        },
        icon: Icon(
          state == 1 ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final startPoint = Offset(0, size.height / 2);
    final controlPoint1 = Offset(size.width / 4, size.height / 3);
    final controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    final endPoint = Offset(size.width, size.height / 2);

    final path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );
    canvas.drawPath(
      _dashPath(
        path,
        dashArray: _CircularIntervalList([4, 4]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Creates a new path that is drawn from the segments of `source`.
///
/// Dash intervals are controled by the `dashArray`
/// see [_CircularIntervalList]
/// for examples.
///
/// `dashOffset` specifies an initial starting point for the dashing.
///
/// Passing a `source` that is an empty path will return an empty path.
Path _dashPath(
  Path source, {
  required _CircularIntervalList<double> dashArray,
  DashOffset? dashOffset,
}) {
  final dashOffset2 = dashOffset ?? const DashOffset.absolute(0);

  final dest = Path();
  for (final metric in source.computeMetrics()) {
    var distance = dashOffset2._calculate(metric.length);
    var draw = true;
    while (distance < metric.length) {
      final len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }

  return dest;
}

enum _DashOffsetType { absolute, percentage }

/// Specifies the starting position of a dash array on a path, either as a
/// percentage or absolute value.
///
/// The internal value will be guaranteed to not be null.
@immutable
class DashOffset {
  /// Create a DashOffset that will be measured as a percentage of the length
  /// of the segment being dashed.
  ///
  /// `percentage` will be clamped between 0.0 and 1.0.
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.percentage;

  /// Create a DashOffset that will be measured in terms of absolute pixels
  /// along the length of a [Path] segment.
  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.absolute
        ? _rawVal
        : length * _rawVal;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DashOffset &&
        other._rawVal == _rawVal &&
        other._dashOffsetType == _dashOffsetType;
  }

  @override
  int get hashCode => Object.hash(_rawVal, _dashOffsetType);
}

/// A circular array of dash offsets and lengths.
///
/// For example, the array `[5, 10]` would result in dashes 5 pixels long
/// followed by blank spaces 10 pixels long.  The array `[5, 10, 5]` would
/// result in a 5 pixel dash, a 10 pixel gap, a 5 pixel dash, a 5 pixel gap,
/// a 10 pixel dash, etc.
///
/// Note that this does not quite conform to an [Iterable<T>], because it does
/// not have a moveNext.
class _CircularIntervalList<T> {
  _CircularIntervalList(this._vals);

  final List<T> _vals;
  int _idx = 0;

  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
