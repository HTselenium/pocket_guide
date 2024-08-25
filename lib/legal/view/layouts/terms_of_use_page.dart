import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/legal/legal.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LegalPage(title: l10n.termsOfUse, data: data);
  }

  String get data => '''
The App only refers to the product portfolio of BASF Home Care and I&I Solutions in Europe, not globally.

**All data to be seen as approximately values**

## **Terms of Use**

This document, or any answers or information provided herein by BASF, does not constitute a legally binding obligation of BASF. While the descriptions, designs, data and information contained herein are presented in good faith and believed to be accurate, it is provided for your guidance only. Because many factors may affect processing or application/use, we recommend that you make tests to determine the suitability of a product for your particular purpose prior to use. It does not relieve our customers from the obligation to perform a full inspection of the products upon delivery or any other obligation.

NO WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, ARE MADE REGARDING PRODUCTS DESCRIBED OR DESIGNS, DATA OR INFORMATION SET FORTH, OR THAT THE PRODUCTS, DESIGNS, DATA OR INFORMATION MAY BE USED WITHOUT INFRINGING THE INTELLECTUAL PROPERTY RIGHTS OF OTHERS. IN NO CASE SHALL THE DESCRIPTIONS, INFORMATION, DATA OR DESIGNS PROVIDED BE CONSIDERED A PART OF OUR TERMS AND CONDITIONS OF SALE.

## **Safety and Labeling**

Please refer to the safety data sheet for information on classification and labeling, safe use, handling and transport.

## **Ecolabel (EU Ecolabel, Blue Angel, Nordic Swan)**

Products labeled with a dot have been evaluated against the respective Ecolabel requirements and might be used as an ingredient in your formulation awarded with a respective Ecolabel for the Home Care and Industrial & Institutional Cleaning market. The information contained in this range chart is presented in good faith, it is provided for your guidance only and does not constitute a legally binding obligation of BASF. Customers are fully responsible to independently evaluate all requirements for such an application. Please note that restrictions may apply. Please contact our regular BASF contact for a detailed statement.

## **Biocides**

Biocides are allowed for use in an Ecolabel detergent product (i) for preservation purposes only, (ii) in the appropriate dosage for this purpose and (iii) only as long as they are not explicitly listed as not allowed under criterion 4 – excluded and restricted substances of the respective Ecolabels. It is the formulators responsibility to check that the relevant PT 6 biocidal product authorizations exist in the countries of use.

$registeredBrands

®  = Registered trademark of BASF in many countries
™ = Trademark of BASF in many countries
''';
}

String registeredBrands = [
  'Cibafast®',
  'Degressal®',
  'Dehydol®',
  'Dehypon®',
  'Dehypound®',
  'Dehyquart®',
  'Dehyton®',
  'Demelan®',
  'Disponil®',
  'Emulan®',
  'Glucopon®',
  'Korantin®',
  'Lavergy®',
  'Lorol®',
  'Lutensit®',
  'Lutensol®',
  'Lutropur®',
  'Luvipur® ',
  'Maranil®',
  'Plantatex®',
  'Plurafac®',
  'Pluriol®',
  'Pluronic®',
  'Poligen®',
  'Polyquart®',
  'Protectol®',
  'Rheovis®',
  'Sokalan®',
  'Sulfopon®',
  'Texapon®',
  'Tinogard®',
  'Tinopal®',
  'Tinosan®',
  'Trilon®',
].join(' • ');
