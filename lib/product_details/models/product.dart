import 'package:flutter/material.dart';

///Product
class Product {
  //#region Declaration of variables
  const Product({
    required this.name,
    required this.prd,
    this.sortNumber,
    this.productGroupName,
    this.productSubgroupName,
    this.chemicalNature,
    this.molarMass,
    this.molarRatio,
    this.concentrationInPercent,
    this.activeContent,
    this.dryContent,
    this.solidsContent,
    this.droppingPointInCelsius,
    this.acidNumber,
    this.density,
    this.bulkDensity,
    this.densityAtDegrees,
    this.amineNumber,
    this.cloudPoint,
    this.solubility,
    this.casNumber,
    this.phValue,
    this.phValueDegrees,
    this.phValueAtWater,
    this.recommendedUseLevel,
    this.shellLife,
    this.activity,
    this.ballHardness,
    this.hlbValue,
    this.meltingPoint,
    this.meltingPointWax,
    this.meltingPointDsc,
    this.meltViscosity,
    this.viscosityDin,
    this.viscosityAtPascal,
    this.viscosityAtDegrees,
    this.physicalForm,
    this.physicalFormAtDegrees,
    this.flowTime,
    this.emulsifierSystem,
    this.bioBased,
    this.bioDegradable,
    this.euEcolabel,
    this.blueAngel,
    this.nordicSwan,
    this.ecoCert,
    this.ecoCertDerogation,
    this.rspo,
    this.additionalInformation,
    this.isSurfactant,
    this.isSokalan,
    this.isRheovis,
    this.isEMEA,
    this.isAPAC,
    this.isNorthAmerica,
    this.isSouthAmerica,
    this.comment,
  });

  //#endregion

  //#region Factory: Build Product from DB
  factory Product.fromJson(Map<String, dynamic> json) {
    if (!json.keys.contains('prd') || !json.keys.contains('product_name')
        // || !json.keys.contains('sortNumber')
        ) {
      throw FormatException('Incorrectly formatted product data: $json');
    }

    final sustainability = json.keys.contains('sustainability')
        ? json['sustainability'] as Map<String, dynamic>
        : null;

    if (sustainability?.keys.contains('bioBased') ?? false) {
      final _bioBased =
          double.parse(sustainability!['bioBased'].toString()).toInt();
      if (_bioBased < 1 || _bioBased > 3) {
        debugPrint('Wrong value for bioBased: $json');
      }
    }

    try {
      return Product(
        prd: int.parse(json['prd'].toString()),
        name: json['product_name'].toString(),
        sortNumber: json.keys.contains('sortNumber')
            ? int.parse(json['sortNumber'].toString())
            : null,
        // productGroupName: json.keys.contains('productGroupName')
        //     ? json['productGroupName'] as List<Map<String, dynamic>>
        //     : null,
        // productSubgroupName: json.keys.contains('product_type')
        //     ? json['product_type'].toString()
        //     : null,
        chemicalNature: json.keys.contains('chemicalNature')
            ? json['chemicalNature'].toString()
            : null,
        molarMass: json.keys.contains('molarMass')
            ? json['molarMass'].toString()
            : null,
        molarRatio: json.keys.contains('molarRatio')
            ? json['molarRatio'].toString()
            : null,
        concentrationInPercent: json.keys.contains('concentrationInPercent')
            ? json['concentrationInPercent'].toString()
            : null,
        activeContent: json.keys.contains('activeContent')
            ? json['activeContent'].toString()
            : null,
        dryContent: json.keys.contains('dryContent')
            ? json['dryContent'].toString()
            : null,
        solidsContent: json.keys.contains('solidsContent')
            ? json['solidsContent'].toString()
            : null,
        droppingPointInCelsius: json.keys.contains('droppingPointInCelsius')
            ? json['droppingPointInCelsius'].toString()
            : null,
        acidNumber: json.keys.contains('acidNumber')
            ? json['acidNumber'].toString()
            : null,
        density:
            json.keys.contains('density') ? json['density'].toString() : null,
        densityAtDegrees: json.keys.contains('densityAtDegrees')
            ? json['densityAtDegrees'].toString()
            : null,
        bulkDensity: json.keys.contains('bulkDensity')
            ? json['bulkDensity'].toString()
            : null,
        amineNumber: json.keys.contains('amineNumber')
            ? json['amineNumber'].toString()
            : null,
        cloudPoint: json.keys.contains('cloudPoint')
            ? json['cloudPoint'].toString()
            : null,
        solubility: json.keys.contains('solubility')
            ? json['solubility'].toString()
            : null,
        casNumber: json.keys.contains('casNumber')
            ? json['casNumber'].toString()
            : null,
        phValue:
            json.keys.contains('phValue') ? json['phValue'].toString() : null,
        phValueDegrees: json.keys.contains('phValueDegrees')
            ? json['phValueDegrees'].toString()
            : null,
        phValueAtWater: json.keys.contains('phValueAtWater')
            ? json['phValueAtWater'].toString()
            : null,
        recommendedUseLevel: json.keys.contains('recommendedUseLevel')
            ? json['recommendedUseLevel'].toString()
            : null,
        shellLife: json.keys.contains('shellLife')
            ? json['shellLife'].toString()
            : null,
        activity:
            json.keys.contains('activity') ? json['activity'].toString() : null,
        ballHardness: json.keys.contains('ballHardness')
            ? json['ballHardness'].toString()
            : null,
        hlbValue:
            json.keys.contains('hlbValue') ? json['hlbValue'].toString() : null,
        meltingPoint: json.keys.contains('meltingPoint')
            ? json['meltingPoint'].toString()
            : null,
        meltingPointWax: json.keys.contains('meltingPointWax')
            ? json['meltingPointWax'].toString()
            : null,
        meltingPointDsc: json.keys.contains('meltingPointDsc')
            ? json['meltingPointDsc'].toString()
            : null,
        meltViscosity: json.keys.contains('meltViscosity')
            ? json['meltViscosity'].toString()
            : null,
        viscosityDin: json.keys.contains('viscosityDin')
            ? json['viscosityDin'].toString()
            : null,
        viscosityAtPascal: json.keys.contains('viscosityAtPascal')
            ? json['viscosityAtPascal'].toString()
            : null,
        viscosityAtDegrees: json.keys.contains('viscosityAtDegrees')
            ? json['viscosityAtDegrees'].toString()
            : null,
        physicalFormAtDegrees: json.keys.contains('physicalFormAtDegrees')
            ? json['physicalFormAtDegrees'].toString()
            : null,
        physicalForm: json.keys.contains('physicalForm')
            ? json['physicalForm'].toString()
            : null,
        flowTime:
            json.keys.contains('flowTime') ? json['flowTime'].toString() : null,
        emulsifierSystem: json.keys.contains('emulsifierSystem')
            ? json['emulsifierSystem'].toString()
            : null,

        //sustainability
        bioBased: sustainability?.keys.contains('bioBased') ?? false
            ? double.parse(sustainability!['bioBased'].toString()).toInt()
            : null,
        euEcolabel: sustainability?.keys.contains('ecoLabel') ?? false
            ? sustainability!['ecoLabel'] as bool
            : null,
        blueAngel: sustainability?.keys.contains('blueAngel') ?? false
            ? sustainability!['blueAngel'] as bool
            : null,
        nordicSwan: sustainability?.keys.contains('nordicSwan') ?? false
            ? sustainability!['nordicSwan'] as bool
            : null,
        ecoCert: sustainability?.keys.contains('ecoCert') ?? false
            ? sustainability!['ecoCert'] as bool
            : null,
        ecoCertDerogation:
            sustainability?.keys.contains('ecoCertDerogation') ?? false
                ? sustainability!['ecoCertDerogation'] as bool
                : null,
        rspo: sustainability?.keys.contains('rspo') ?? false
            ? sustainability!['rspo'] as bool
            : null,
        bioDegradable: sustainability?.keys.contains('bioDegradable') ?? false
            ? sustainability!['bioDegradable'] as bool
            : null,

        //additional information
        additionalInformation: json.keys.contains('additionalInformation')
            ? json['additionalInformation'].toString()
            : null,
        isSurfactant: json.keys.contains('isSurfactant')
            ? json['isSurfactant'] as bool
            : null,
        isSokalan:
            json.keys.contains('isSokalan') ? json['isSokalan'] as bool : null,
        isRheovis:
            json.keys.contains('isRheovis') ? json['isRheovis'] as bool : null,

        //region
        isEMEA: json.keys.contains('isEMEA') ? json['isEMEA'] as bool : null,
        isAPAC: json.keys.contains('isAPAC') ? json['isAPAC'] as bool : null,
        isNorthAmerica: json.keys.contains('isNorthAmerica')
            ? json['isNorthAmerica'] as bool
            : null,
        isSouthAmerica: json.keys.contains('isSouthAmerica')
            ? json['isSouthAmerica'] as bool
            : null,
        comment:
            json.keys.contains('comment') ? json['comment'] as String : null,
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(json['prd'].toString());
      throw Exception(
        'Error during product data interpretation: ${json['prd']}',
      );
    }
  }

  final int prd;
  final String name;
  final int? sortNumber;
  final String? productGroupName;
  final String? productSubgroupName;

  ///Relevant for HomeCare & Industrial Formulators
  ///Chemical nature
  final String? chemicalNature;

  ///Relevant for HomeCare & Industrial Formulators
  ///Molar mass [g/mol]
  final String? molarMass;

  ///Relevant for Industrial Formulators
  ///Molar ratio [SiO2/Alk2O]
  final String? molarRatio;

  ///Relevant for HomeCare & Industrial Formulators
  ///Concentration [%]
  final String? concentrationInPercent;

  ///Relevant for HomeCare & Industrial Formulators
  ///Active content [%]
  final String? activeContent;

  ///Relevant for Industrial Formulators
  ///Dry  content [%]
  final String? dryContent;

  ///Relevant for HomeCare & Industrial Formulators
  ///Solids content [%]
  final String? solidsContent;

  ///Relevant for HomeCare
  ///Dropping point Ubbelohde [°C] DIN  ISO 2176  ASTM  D-3954
  final String? droppingPointInCelsius;

  ///Relevant for HomeCare & Industrial Formulators
  ///HC: Acid number [mg KOH/g] DIN EN ISO 2114 ASTM D-1386
  ///IF: Acid number [mg KOH/g]
  final String? acidNumber;

  ///Relevant for HomeCare & Industrial Formulators
  ///Density [g/cm3]
  final String? density;

  ///Relevant for HomeCare & Industrial Formulators
  ///Bulk density [g/L]
  final String? bulkDensity;

  ///Relevant for HomeCare
  ///Density at 20 °C [g/cm3]
  final String? densityAtDegrees;

  ///Relevant for HomeCare & Industrial Formulators
  ///Amine number [mg KOH/g]
  final String? amineNumber;

  ///Relevant for HomeCare & Industrial Formulators
  ///Cloud point [°C]
  final String? cloudPoint;

  ///Relevant for HomeCare
  ///Solubility
  final String? solubility;

  ///Relevant for HomeCare & Industrial Formulators
  ///CAS Number (active substance)
  final String? casNumber;

  ///Relevant for HomeCare & Industrial Formulators
  ///pH
  final String? phValue;

  ///Relevant for HomeCare
  ///pH-value 23 °C DIN 19268
  final String? phValueDegrees;

  ///Relevant for HomeCare & Industrial Formulators
  ///pH 1% in Water
  final String? phValueAtWater;

  ///Relevant for HomeCare
  ///Recommended use level [%]
  final String? recommendedUseLevel;

  ///Relevant for HomeCare
  ///Shelf life
  final String? shellLife;

  ///Relevant for HomeCare
  ///Activity [BPU*/g]
  final String? activity;

  ///Relevant for HomeCare & Industrial Formulators
  ///HC: Ball hardness (Fischer, 23 °C) [N/mm2] DIN EN ISO 6507-1
  ///IF: Ball hardness [N/mm2]
  final String? ballHardness;

  ///Relevant for HomeCare & Industrial Formulators
  ///HLB value
  final String? hlbValue;

  ///Relevant for HomeCare & Industrial Formulators
  ///Melting point [°C]
  final String? meltingPoint;

  ///Relevant for Industrial Formulators
  ///Melting point of the wax [°C]
  final String? meltingPointWax;

  ///Relevant for Industrial Formulators
  ///Melting point DSC [°C]
  final String? meltingPointDsc;

  ///Relevant for HomeCare
  ///Melt viscosity [mPa·s] BASF Method RotoVisco 1 (120 °C)
  final String? meltViscosity;

  ///Relevant for HomeCare
  ///Viscosity (ISO cup, 4 mm) [s] DIN EN ISO 2431
  final String? viscosityDin;

  ///Relevant for HomeCare & Industrial Formulators
  ///Viscosity [mPa·s]
  final String? viscosityAtPascal;

  ///Relevant for HomeCare
  ///Viscosity at 75 °C [mm2/s]
  final String? viscosityAtDegrees;

  ///Relevant for HomeCare & Industrial Formulators
  ///Physical Form
  final String? physicalForm;

  ///Relevant for HomeCare & Industrial Formulators
  ///Physical form [23 °C]
  final String? physicalFormAtDegrees;

  ///Relevant for Industrial Formulators
  ///Flow time [s]
  final String? flowTime;

  ///Relevant for Industrial Formulators
  ///Emulsifier system
  final String? emulsifierSystem;

  ///Relevant for HomeCare & Industrial Formulators
  ///Bio-based Surfactant
  final int? bioBased;

  ///Relevant for HomeCare & Industrial Formulators
  ///Biodegradability
  final bool? bioDegradable;

  ///Relevant for HomeCare
  final bool? euEcolabel;

  ///Relevant for HomeCare
  final bool? blueAngel;

  ///Relevant for HomeCare
  final bool? nordicSwan;

  ///Relevant for HomeCare
  final bool? ecoCert;

  ///Relevant for HomeCare
  final bool? ecoCertDerogation;

  ///Relevant for HomeCare
  ///Available products with RSPO certificates
  final bool? rspo;

  ///Relevant for HomeCare & Industrial Formulators
  final String? additionalInformation;

  ///Relevant for HomeCare
  final bool? isSurfactant;

  ///Relevant for HomeCare
  final bool? isSokalan;

  ///Relevant for HomeCare
  final bool? isRheovis;

  ///Relevant for region setting
  final bool? isEMEA;
  final bool? isAPAC;
  final bool? isNorthAmerica;
  final bool? isSouthAmerica;

  ///Comment
  final String? comment;
//#endregion
}
