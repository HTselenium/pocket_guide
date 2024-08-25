import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class AskRedisoPage extends StatelessWidget {
  const AskRedisoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    const color = Colors.white;

    return Theme(
      /// So it doesn't change if theme is dark or light
      data: AppTheme.darkTheme,
      child: Stack(
        children: [
          Assets.images.redisoBackground.image(
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(l10n.askRediso),
              leading: IconButton(
                icon: Icon(Icons.adaptive.arrow_back),
                onPressed: () => context.go(NavBarLayout.tiles[0].route.path),
              ),
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VerticalSpacer.xxxLarge(),
                      Assets.svgs.redisoLogo.svg(),
                      VerticalSpacer.xxLarge(),
                      Text(
                        l10n.askRedisoTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacer.xLarge(),
                      Text(
                        l10n.askRedisoSubtitle,
                        style: const TextStyle(fontSize: 16, color: color),
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacer.large(),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            l10n.goToRediso,
                            style: const TextStyle(
                              color: Color(0xff21A0D2),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () =>
                              _launchUniversalLink(theme.primaryColor),
                        ),
                      ),
                      VerticalSpacer.xxxLarge(),
                    ],
                  ).padded(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUniversalLink(Color color) async {
  const url = 'https://www.rediso.org';

  final uri = Uri.parse(url);

  // Web or industrial devices directly launch the url
  return kIsWeb
      ? await launchUrl(uri)
      : await ChromeSafariBrowser().open(
          url: uri,
          options: ChromeSafariBrowserClassOptions(
            android: AndroidChromeCustomTabsOptions(
              keepAliveEnabled: true,
              toolbarBackgroundColor: color,
            ),
            ios: IOSSafariOptions(
              preferredControlTintColor: color,
              preferredBarTintColor: Colors.white,
            ),
          ),
        );

  // URL Launcher approach
  /*
  Future<void> _launchUniversalLink(String url) async {
    final uri = Uri.parse(url);
  
    if (!await canLaunchUrl(uri)) return; // We exit if we can't open it
    await launchUrl(
      uri,
      mode: Platform.isIOS
          // Inappbrowser gets stuck in android
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
      // For web, it opens a new tab anyway
    );
  }*/
}
