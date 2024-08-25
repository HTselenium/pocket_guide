import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pocket_guide/core/core.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? _CustomAppVersionButton(packageInfo: snapshot.data!)
            : const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 3),
              );
      },
    );
  }
}

class _CustomAppVersionButton extends StatelessWidget {
  const _CustomAppVersionButton({required this.packageInfo});
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_env(theme), _version(l10n, theme), _buildNumber(theme)],
      ),
      onPressed: () => showLicensePage(
        context: context,
        applicationIcon: Assets.svgs.pocketGuideLogo
            .svg(
              colorFilter:
                  ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              height: 20,
            )
            .padded(const EdgeInsets.symmetric(vertical: Dimens.paddingLarge)),
        applicationVersion: packageInfo.version,
        applicationName: packageInfo.appName,
        applicationLegalese: _appLegalese,
      ),
    );
  }

  String get _appLegalese => '© ${DateTime.now().year} BASF';

  Widget _env(ThemeData theme) => Text(
        (Environment.env.toLowerCase() != 'prod' ? '${Environment.env} · ' : '')
            .toUpperCase(),
        style: theme.textTheme.titleLarge!.copyWith(
          color: theme.primaryColor,
          fontSize: 16,
        ),
      );

  Widget _version(AppLocalizations l10n, ThemeData theme) => Text(
        '${l10n.generalVersion} ${packageInfo.version}',
        style: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.grey,
          fontSize: 16,
        ),
      );

  Widget _buildNumber(ThemeData theme) => Text(
        ' + ${Environment.buildNumber}',
        style: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade500,
          fontSize: 10,
        ),
      );
}
