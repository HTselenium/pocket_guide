import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/get_it_service.dart';
import 'package:pocket_guide/product_details/product_details.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.prd,
    required this.category,
  });

  final String id;
  final String prd;
  final int category;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsPage> {
  late final Map<String, dynamic> _productData;
  late Product product;
  late List<dynamic> claimsList = [];

  final biodegradableIcon = const Image(
    image: AssetImage('assets/images/Biodegradable.png'),
    height: 20,
  );

  final rspoIcon = const Image(
    image: AssetImage('assets/images/Palm_Oil_Icon.png'),
    height: 20,
  );

  final bioBasedIcon = const Image(
    image: AssetImage('assets/images/BioBased_Icon.png'),
    height: 20,
  );

  @override
  void initState() {
    super.initState();
    final prd = int.parse(widget.prd);
    if (widget.key.toString().contains('product-portfolio-industrial')) {
      final industryProductBox = Hive.box<dynamic>('industryProductBox');
      _productData = industryProductBox.get(prd) as Map<String, dynamic>;
      if (_productData.keys.contains('application_group')) {
        claimsList = _productData['application_group'] as List;
      }
    } else if (widget.key.toString().contains('product-portfolio-home-care')) {
      final hcProductBox = Hive.box<dynamic>('hcProductBox');
      _productData = hcProductBox.get(prd) as Map<String, dynamic>;
      if (_productData.keys.contains('application_group')) {
        claimsList = _productData['application_group'] as List;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            product = Product.fromJson(_productData);
            final showImportantRemarks =
                product.additionalInformation != null ||
                    product.droppingPointInCelsius != null ||
                    product.acidNumber != null ||
                    product.ballHardness != null ||
                    product.meltViscosity != null ||
                    product.viscosityDin != null ||
                    product.comment != null ||
                    (product.nordicSwan ?? false);
            return CustomScrollView(
              slivers: [
                CustomAppBar(
                  isFirstList: false,
                  color: ProductCategory.all[widget.category].color,
                  leading: true,
                  title: product.name,
                  prd: product.prd.toString(),
                  hasFavourite: true,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      detailContainer(),
                      if (showImportantRemarks) importantRemarks(),
                      if (product.bioDegradable ?? false) biodegradableTable(),
                      if (product.bioBased != null) bioBasedTable(),
                      if (product.isSurfactant ?? false) surfactantTable(),
                      if (product.isSokalan ?? false) sokalanTable(),
                      if (product.isRheovis ?? false) rheovisTable(),
                    ].joinWith(VerticalSpacer.medium()),
                  ).padded(
                    const EdgeInsets.symmetric(
                      vertical: Dimens.paddingMedium,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget detailContainer() {
    final showSustainabilityLabels = (product.euEcolabel ?? false) ||
        (product.blueAngel ?? false) ||
        (product.nordicSwan ?? false) ||
        (product.ecoCert ?? false) ||
        (product.ecoCertDerogation ?? false);

    final showClaimButton =
        widget.key.toString().contains('product-portfolio-home-care');

    return Builder(
      builder: (context) {
        final theme = context.theme;
        final isDark = context.theme.isDark;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkBackground(theme) : Colors.white,
            boxShadow: [AppTheme.shadow()],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              productAttributes(),
              if (showSustainabilityLabels) sustainableLabels(),
              if (showClaimButton && claimsList.isNotEmpty)
                directClaimButton(product.name),
            ],
          ),
        );
      },
    );
  }

  Widget productAttributes() {
    return Padding(
      padding: const EdgeInsets.all(Dimens.paddingMediumLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailsTitle(title: 'Details'),

          if (product.chemicalNature != null)
            DetailsRow(
              title: 'Chemical nature',
              value: product.chemicalNature!,
            ),

          if (product.molarMass != null)
            DetailsRow(
              title: 'Molar mass [g/mol]',
              value: product.molarMass!,
            ),

          if (product.molarRatio != null)
            DetailsRow(
              title: 'Molar ratio [SiO₂/Alk₂O]',
              value: product.molarRatio!,
            ),

          if (product.concentrationInPercent != null)
            DetailsRow(
              title: 'Concentration [%]',
              value: product.concentrationInPercent!,
            ),

          if (product.activeContent != null)
            DetailsRow(
              title: 'Active content [%]',
              value: product.activeContent!,
            ),

          if (product.dryContent != null)
            DetailsRow(
              title: 'Dry content [%]',
              value: product.dryContent!,
            ),

          if (product.solidsContent != null)
            DetailsRow(
              title: 'Solids content [%]',
              value: product.solidsContent!,
            ),

          if (product.droppingPointInCelsius != null)
            DetailsRow(
              title: 'Dropping point Ubbelohde¹⁾ [°C]',
              value: product.droppingPointInCelsius!,
            ),

          if (product.acidNumber != null)
            DetailsRow(
              title: 'Acid number²⁾ [mg KOH/g]',
              value: product.acidNumber!,
            ),

          if (product.density != null)
            DetailsRow(
              title: 'Density [g/cm³]',
              value: product.density!,
            ),

          if (product.densityAtDegrees != null)
            DetailsRow(
              title: 'Density at 20°C [g/cm³]',
              value: product.densityAtDegrees!,
            ),

          if (product.amineNumber != null)
            DetailsRow(
              title: 'Amine number [mg KOH/g]',
              value: product.amineNumber!,
            ),

          if (product.cloudPoint != null)
            DetailsRow(
              title: 'Cloud point [°C]',
              value: product.cloudPoint!,
            ),

          if (product.solubility != null)
            DetailsRow(
              title: 'Solubility',
              value: product.solubility!,
            ),

          if (product.casNumber != null)
            DetailsRow(
              title: 'CAS Number (active substance)',
              value: product.casNumber!,
            ),

          if (product.phValueDegrees != null)
            DetailsRow(
              title: 'pH-value 23°C DIN 19268',
              value: product.phValueDegrees!,
            ),

          if (product.phValueAtWater != null)
            DetailsRow(
              title: 'pH 1% in Water',
              value: product.phValueAtWater!,
            ),

          if (product.phValue != null)
            DetailsRow(
              title: 'pH Value',
              value: product.phValue!,
            ),

          if (product.recommendedUseLevel != null)
            DetailsRow(
              title: 'Recommended use level (%)',
              value: product.recommendedUseLevel!,
            ),

          if (product.shellLife != null)
            DetailsRow(
              title: 'Shelf life',
              value: product.shellLife!,
            ),

          if (product.activity != null)
            DetailsRow(
              title: 'Activity [BCU/BPU/BMU*/g]',
              value: product.activity!,
            ),

          if (product.ballHardness != null)
            DetailsRow(
              title: 'Ball hardness³⁾ [N/mm²]',
              value: product.ballHardness!,
            ),

          if (product.hlbValue != null)
            DetailsRow(
              title: 'HLB value',
              value: product.hlbValue!,
            ),

          if (product.meltingPointWax != null)
            DetailsRow(
              title: 'Melting point of the wax [°C]',
              value: product.meltingPointWax!,
            ),

          if (product.meltingPointDsc != null)
            DetailsRow(
              title: 'Melting point DSC [°C]',
              value: product.meltingPointDsc!,
            ),

          if (product.meltingPoint != null)
            DetailsRow(
              title: 'Melting point [°C]',
              value: product.meltingPoint!,
            ),

          if (product.bulkDensity != null)
            DetailsRow(
              title: 'Bulk density [g/L]',
              value: product.bulkDensity!,
            ),

          if (product.meltViscosity != null)
            DetailsRow(
              title: 'Melt viscosity⁴⁾ [mPa·s]',
              value: product.meltViscosity!,
            ),

          if (product.viscosityDin != null)
            DetailsRow(
              title: 'Viscosity⁵⁾ [s]',
              value: product.viscosityDin!,
            ),

          if (product.viscosityAtPascal != null)
            DetailsRow(
              title: 'Viscosity [mPa·s]',
              value: product.viscosityAtPascal!,
            ),

          if (product.viscosityAtDegrees != null)
            DetailsRow(
              title: 'Viscosity at 75°C\n[mm²/s]',
              value: product.viscosityAtDegrees!,
            ),

          if (product.physicalFormAtDegrees != null)
            DetailsRow(
              title: 'Physical form [23°C]',
              value: product.physicalFormAtDegrees!,
            ),

          if (product.physicalForm != null)
            DetailsRow(
              title: 'Physical Form',
              value: product.physicalForm!,
            ),

          if (product.flowTime != null)
            DetailsRow(
              title: 'Flow time [s]',
              value: product.flowTime!,
            ),

          if (product.emulsifierSystem != null)
            DetailsRow(
              title: 'Emulsifier system',
              value: product.emulsifierSystem!,
            ),

          ///Sustainability Labels
          if (product.bioDegradable ?? false)
            DetailsIconRow(
              title: 'Biodegradable⁶⁾',
              value: biodegradableIcon,
            ),
          if (product.rspo ?? false)
            DetailsIconRow(
              title: product.name.endsWith('/MB')
                  ? 'RSPO Certified'
                  : '(Optionally) RSPO Certified',
              value: rspoIcon,
            ),
          if (product.bioBased != null)
            DetailsIconRow(
              title: 'Bio-Based⁷⁾',
              value: _bioBasedIconRow(product.bioBased!),
            ),
        ].joinWith(VerticalSpacer.normal()),
      ),
    );
  }

  Widget sustainableLabels() {
    final labels = [
      if (product.euEcolabel ?? false) 'EU Ecolabel',
      if (product.blueAngel ?? false) 'Blue Angel',
      if (product.nordicSwan ?? false) 'Nordic Swan',
      if (product.ecoCert ?? false) 'Ecocert',
      if (product.ecoCertDerogation ?? false) '(Ecocert)*',
    ].join(', ');

    return Builder(
      builder: (context) {
        final theme = context.theme;
        return Container(
          padding: const EdgeInsets.all(Dimens.paddingMediumLarge),
          color: AppTheme.darkBlueSwatch.shade200.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Suitable for',
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.theme.isDark
                      ? const Color(AppTheme.lightGreyColor)
                      : AppTheme.darkBlueSwatch.shade700,
                ),
              ),
              VerticalSpacer.normal(),
              Text(
                labels,
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkBlueSwatch.shade900,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget directClaimButton(String prodName) {
    return Builder(
      builder: (context) {
        final theme = context.theme;
        return ElevatedButton(
          onPressed: () {
            pianoFlutterPlugin.trackEvent('click.action', {
              'click': 'product_go_claim_click',
              'click_chapter1': 'product_detail',
              'product_name': product.name,
              'product_prd': product.prd,
            });
            context.push(
              '${AppRoutes.productPortfolioHomeCare.path}/product/${widget.category}/${product.prd}/${product.prd}/${product.prd}/${product.prd}/$prodName',
              extra: claimsList,
            );
          },
          style: AppTheme.primaryButtonTheme(theme),
          child: Text(
            context.l10n.buttonToClaims,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.theme.isDark
                  ? Colors.white
                  : const Color(AppTheme.darkBlueColor),
            ),
          ),
        );
      },
    );
  }

  Widget importantRemarks() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailsTitle(title: 'Important remarks'),
            if (product.additionalInformation != null)
              _infoText(product.additionalInformation!),
            if (product.droppingPointInCelsius != null)
              _infoText('¹⁾ DIN ISO 2176, ASTM D-3954'),
            if (product.acidNumber != null)
              _infoText('²⁾ DIN EN ISO 2114, ASTM D-1386'),
            if (product.ballHardness != null)
              _infoText('³⁾ Fischer, 23°C, DIN EN ISO 6507-1'),
            if (product.meltViscosity != null)
              _infoText('⁴⁾ BASF Method, RotoVisco 1 (120°C)'),
            if (product.viscosityDin != null)
              _infoText('⁵⁾ ISO cup, 4mm, DIN EN ISO 2431'),
            if (product.nordicSwan ?? false)
              _infoText(
                  'Nordic Swan: At least one out of nine criteria is accessed '
                  'if "suitable".\nFor new evaluations: Nordic Swan '
                  'might be possible if EU Ecolabel is suitable.\n'
                  'For some products there might be a concentration of '
                  'use limitation.'),
            if (product.comment != null) _infoText(product.comment!),
          ].joinWith(VerticalSpacer.semi()),
        ).padded(
          const EdgeInsets.symmetric(
            vertical: Dimens.paddingSemi,
            horizontal: Dimens.paddingMediumLarge,
          ),
        );
      },
    );
  }

  Widget biodegradableTable() {
    return _detailsInfoTable(
      [
        Text(
          '⁶⁾ According to OECD 301. In case of mixtures all organic '
          'components are readily biodegradable',
          style: context.theme.textTheme.bodyMedium!.copyWith(
            color: const Color(AppTheme.greyColor),
          ),
        ),
        VerticalSpacer.mediumLarge(),
        ...[
          const DetailsTitleRow(title: 'Biodegradability', value: 'Icon'),
          DetailsIconRow(
            title: 'Readily biodegradable',
            value: biodegradableIcon,
          ),
          const DetailsRow(title: 'Not readily biodegradable', value: ''),
        ].joinWith(const SeparatorLine()),
      ],
    );
  }

  Widget bioBasedTable() {
    return Builder(
      builder: (context) {
        final theme = context.theme;
        return _detailsInfoTable(
          [
            Text(
              product.isSurfactant ?? false
                  ? '⁷⁾ according to the EN17035 surfactant classification'
                  : '⁷⁾ Our bio-based portfolio beyond surfactants classified '
                      'according to below logic',
              style: context.theme.textTheme.bodyMedium!.copyWith(
                color: const Color(AppTheme.greyColor),
              ),
            ),
            VerticalSpacer.mediumLarge(),
            ...[
              DetailsTitleRow(
                title: widget.key
                        .toString()
                        .contains('product-portfolio-home-care')
                    ? (product.isSurfactant ?? false
                        ? 'Surfactant Classification'
                        : 'Bio-based Classification')
                    : 'Product Classification',
                value: 'Bio-based carbon [X% of total C]',
                value2: 'Icon',
              ),
              DetailsIconRow(
                title: 'Wholly bio-based',
                value: Text(
                  'X ≥ 95',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: const Color(AppTheme.greyColor),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value2: _bioBasedIconRow(3),
              ),
              DetailsIconRow(
                title: 'Majority bio-based',
                value: Text(
                  '95 > X > 50',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: const Color(AppTheme.greyColor),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value2: _bioBasedIconRow(2),
              ),
              DetailsIconRow(
                title: 'Minority bio-based',
                value: Text(
                  '50 > X > 5',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: const Color(AppTheme.greyColor),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value2: _bioBasedIconRow(1),
              ),
              DetailsIconRow(
                title: 'Non bio-based',
                value: Text(
                  'X ≤ 5',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: const Color(AppTheme.greyColor),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value2: _bioBasedIconRow(0),
              ),
            ].joinWith(const SeparatorLine()),
          ],
        );
      },
    );
  }

  Widget surfactantTable() {
    return _detailsInfoTable(
      [
        const DetailsTitle(title: 'Test methods of Surfactants'),
        VerticalSpacer.mediumLarge(),
        ...[
          _infoText('• Cloud point in °C according to EN 1890:'),
          _infoText('- Method A: 1g surfactant + 100g distilled water'),
          _infoText(
            '- Method B: 1g surfactant + 100g NaCl solution (c = 50g/L)',
          ),
          _infoText(
            '- Method B: 1g surfactant + 100g NaCl solution (c = 100g/L)',
          ),
          _infoText(
            '- Method C: 5g surfactant + 45g of diethylene glycol monobutyl ether solution (c = 250g/L)',
          ),
          _infoText(
            '- Method E: 5g surfactant + 25g of diethylene glycol monobutyl ether solution (c = 250g/L)',
          ),
          _infoText('• Viscosity: EN 12092 Brookfield, 60rpm [mPa·s], 23°C'),
          _infoText('• Viscosity: Ubbelohde according to DIN 51562 [mm²/s]'),
          _infoText(
            '• Molar mass calculated from hydroxyl number according to DIN 53240 or PSA method',
          ),
          _infoText('• HLB value according to W.C. Griffin'),
          _infoText('• Melting point: BASF method'),
        ].joinWith(const SeparatorLine()),
      ],
    );
  }

  Widget sokalanTable() {
    return _detailsInfoTable(
      [
        const DetailsTitle(title: 'Test methods for Sokalan types'),
        VerticalSpacer.mediumLarge(),
        ...[
          const DetailsRow(title: 'Physical form', value: 'at 25°C'),
          const DetailsRow(
            title: 'Concentration',
            value: 'ISO 3251 drying to constant mass',
          ),
          const DetailsRow(
            title: 'Average molar mass',
            value: 'Gel Permeation Chromatography (calibration '
                'with polystryene sulfonates/ or polycrylates)',
          ),
          const DetailsRow(
            title: 'pH-Value',
            value: 'DIN 19268, 10% dry substance in dist. Water',
          ),
          const DetailsRow(title: 'Bulk density', value: 'ISO 697'),
          const DetailsRow(title: 'Density', value: 'DIN 51757, 25°C'),
          const DetailsRow(
            title: 'Viscosity',
            value: 'Brookfield, 25°C, undiluted',
          ),
        ].joinWith(const SeparatorLine()),
      ],
    );
  }

  Widget rheovisTable() {
    return _detailsInfoTable(
      [
        const DetailsTitle(title: 'Test methods for Rheovis types'),
        VerticalSpacer.mediumLarge(),
        ...[
          const DetailsRow(title: 'Physical form', value: 'at 25°C'),
          const DetailsRow(
            title: 'Concentration',
            value: 'Specific for each product, '
                'please refer to the Product Specification',
          ),
          const DetailsRow(
            title: 'pH-Value',
            value: 'DIN 19268, 1% in dist. Water',
          ),
          const DetailsRow(title: 'Bulk density', value: 'ISO 697'),
          const DetailsRow(title: 'Density', value: 'DIN 51757, 25°C'),
          const DetailsRow(
            title: 'Viscosity',
            value: 'Brookfield, 25°C, undiluted',
          ),
        ].joinWith(const SeparatorLine()),
      ],
    );
  }

  Widget _detailsInfoTable(List<Widget> children) {
    return Builder(
      builder: (context) {
        final theme = context.theme;
        return Container(
          padding: const EdgeInsets.all(Dimens.paddingMediumLarge),
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.isDark
                ? AppTheme.darkBackground(theme)
                : Colors.white,
            boxShadow: [AppTheme.shadow()],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      },
    );
  }

  Widget _bioBasedIconRow(int numberOfIcons) {
    final iconWidgets = <Widget>[];
    for (var i = 0; i < numberOfIcons; i++) {
      iconWidgets.add(bioBasedIcon);
    }
    return Row(children: iconWidgets.joinWith(HorizontalSpacer.small()));
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: context.theme.textTheme.bodyMedium!.copyWith(
        color: const Color(AppTheme.greyColor),
      ),
    );
  }
}
