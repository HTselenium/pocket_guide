import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/settings/settings.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimens.paddingMedium,
      runSpacing: Dimens.paddingMedium,
      children: List.generate(
        ThemeMode.values.length,
        (index) => _CustomCoiceChip(index: index),
      ),
    );
  }
}

class _CustomCoiceChip extends StatelessWidget {
  const _CustomCoiceChip({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ), // Set your desired border color here
        borderRadius:
            BorderRadius.circular(10), // Adjust border radius as needed
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.paddingMedium20,
        vertical: Dimens.paddingMediumSmall,
      ),
      onSelected: (value) =>
          context.read<SettingsCubit>().updateTheme(ThemeMode.values[index]),
      selected: context.select((SettingsCubit c) => c.state.themeMode) ==
          ThemeMode.values[index],
      checkmarkColor: Colors.white,
      label: Column(
        children: [
          Icon(
            _icon(ThemeMode.values[index]),
            color: Colors.white,
          ),
          VerticalSpacer.small(),
          Text(
            ThemeMode.values[index].localeTheme(context),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  IconData _icon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.brightness_6;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}
