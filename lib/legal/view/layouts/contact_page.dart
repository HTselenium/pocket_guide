import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/legal/legal.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LegalPage(title: l10n.contact, data: data);
  }

  String get data => '''
BASF SE, Carl-Bosch-Str. 38

67056 Ludwigshafen

Germany

Home Care and I&I Solutions: [detergents-cleaners-eu@basf.com](mailto:detergents-cleaners-eu@basf.com)

Industrial Formulators: [industrial-formulators-eu@basf.com](mailto:industrial-formulators-eu@basf.com)
''';
}
