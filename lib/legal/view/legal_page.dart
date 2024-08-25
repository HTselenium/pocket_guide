import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalPage extends HookWidget {
  const LegalPage({
    super.key,
    required this.title,
    required this.data,
    this.actions,
  });

  final String title;
  final String data;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isVisible = useState(false);
    final scrollController = useScrollController();

    void listener() {
      if (scrollController.offset > 250) {
        isVisible.value = true;
      } else {
        isVisible.value = false;
      }
    }

    useEffect(
      () {
        scrollController.addListener(listener);
        return () => scrollController.removeListener(listener);
      },
      [scrollController],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () => context.go(AppRoutes.settings.path),
        ),
        title: Text(title),
        actions: actions,
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isVisible.value ? 1.0 : 0.0,
        child: FloatingActionButton(
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.expand_less),
          onPressed: () => scrollController.animateTo(
            0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ),
      body: Markdown(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        selectable: true,
        onTapLink: _onTap,
        data: '$data$_footer',
      ),
    );
  }

  Future<void> _onTap(String text, String? link, String _) async {
    if (link != null) {
      final uri = Uri.parse(link);

      if (!await launchUrl(uri)) 'Could not launch $uri'.log();
    }
  }

  String get _footer => '''
# [![BASF logo][]][basf.com]

[BASF logo]: resource:${Assets.images.basfOutlinedLogo.path}
[basf.com]: https://basf.com/
''';
}
