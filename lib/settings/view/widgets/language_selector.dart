import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/settings/settings.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
      child: DropdownButton<Languages>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.expand_more),
        borderRadius: AppTheme.defaultBorderRadius,
        dropdownColor: AppTheme.darkPopup(theme),
        value: context.select((SettingsCubit c) => c.state.language),
        items: List.generate(
          Languages.all.length,
          (index) => DropdownMenuItem(
            value: Languages.all[index],
            child: Text(Languages.all[index].text.toTitleCase()),
          ),
        ),
        onChanged: (newLanguage) {
          if (newLanguage != null) {
            context.read<SettingsCubit>().updateLanguage(newLanguage);
          }
        },
      ),
    );
  }
}
