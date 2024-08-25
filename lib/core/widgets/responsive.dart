import 'package:flutter/material.dart';

const _mobileWidth = 600;
const _tabletWidth = 1024;

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.web,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? web;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= _mobileWidth) {
            return mobile;
          } else if (constraints.maxWidth <= _tabletWidth) {
            return tablet ?? mobile;
          }

          return web ?? tablet ?? mobile;
        },
      ),
    );
  }
}

bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < _mobileWidth;

bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width < _tabletWidth &&
    MediaQuery.of(context).size.width >= _mobileWidth;

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= _tabletWidth;
