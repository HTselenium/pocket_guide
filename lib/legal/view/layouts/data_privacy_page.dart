import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/core/utils/one_trust.dart';
import 'package:pocket_guide/legal/legal.dart';

class DataPrivacyPage extends StatefulWidget {
  const DataPrivacyPage({super.key});

  @override
  State<DataPrivacyPage> createState() => _DataPrivacyPageState();
}

class _DataPrivacyPageState extends State<DataPrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LegalPage(
      title: l10n.dataPrivacy,
      data: data,
      actions: const [OneTrustWidget()],
    );
  }

  String get data => '''
## **PRIVACY NOTICE FOR Pocket Guide APP (HOME CARE AND I&I)**

Last updated: 21.10.2020

#### **1. Introduction**

With this App, BASF SE, Carl-Bosch-Straße 38, 67056 Ludwigshafen (following “we” or “us”) enables you to retrieve and display the following information: product specific information (chemical nature and values, information about sustainability aspects and claims by application). We use Google as service provider to provide latest App data about product information and anonymous report and statistic functions. When you use the App, we do not collect or process any personal data about you. Personal data are all information related to an identified or an identifiable natural person.

Because of the usage of Google infrastructure, we have no influence on the data transfer to or the processing of Google itself. With this privacy notice we want to give you a transparent overview of possible data processing.

You can access this privacy notice at any time via the menu item “Data Privacy” within the App.

#### **2. Information of the processing of your personal data**
##### **2.1 Anonymous data collection by us**
As part of your use of the App, we automatically collect certain anonymous data required to use the App. These include: Operating system, region of session, device model, screen resolution and crash analyses. In particular, the data are processed because they are necessary to guarantee or improve the functionality of the App.

##### **2.2 Data collected by Google**
This App uses the Firebase Framework of Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA. By using this Google infrastructure, this App may send personal data to Google which is not used for our purposes like anonymous statistics. At the time being, we can't provide our service without these data transfers to Google LLC.

With this infrastructure, we have no influence on data processing procedures, nor are we aware of the full extent of the data collection, the purposes of the processing and the storage periods. We also have no information about the deletion of the collected data by Google or other Companies which might get access to this data.

In the course of the data transfer to Google, your personal data will be transferred to servers of Google, which might also be located in the USA. The USA is a country that does not have a level of data protection which is adequate to that of the EU. In particular, this means that personal data can be accessed by US authorities in a simplified manner and that there are only limited rights to such measures.

For further information we advise you to use the following link:

[Firebase Data collection](https://support.google.com/firebase/answer/6318039?hl=en)

##### **2.3 Technical Authorizations**

We are not collecting any personal data while using the App.

The App requires the following technical authorizations to provide you with the latest product information:

- Internet access: Download the latest version of the content.

#### **3. Data subject rights**

As far as personal data is processed, you can request information about the data stored. In addition, under certain circumstances, you can demand the correction or deletion of your personal data. You may also have a right to restrict the processing of your personal data and a right to have the data provided by you released in a structured, common and machine-readable format.

If you have given your consent to the processing of your personal data, you have the right to withdraw your consent at any time without giving reasons.

Please note that the withdrawal is only effective for the future. Processing that took place before the withdrawal is not affected.

You have the right to submit a complaint to the data protection officer or to a data protection supervisory authority. Without prejudice to any other administrative or judicial remedy, you have the right to lodge a complaint with a supervisory authority, in particular in the Member State in which you are resident or in which the place of alleged infringement is located, if you consider that the processing of your personal data is contrary to the GDPR.

The supervisory authority to which the complaint has been lodged will inform the complainant of the status and outcome of the complaint, including the possibility of a judicial remedy under Article 78 GDPR.

#### **4. Contact Information**

If you have any questions or remarks about the handling of your personal data or wish to exercise your rights under section 3, we advise to use the following link:

[Firebase Data Privacy Inquiries](https://firebase.google.com/support/privacy/dpo)

#### **5. Updates**

From time to time, we will update this privacy notice. Any changes will become effective when we post the revised privacy notice in the App. This privacy notice was last updated as of the “Last Updated” date shown above.
''';
}
