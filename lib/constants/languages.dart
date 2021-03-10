import 'package:flutter/material.dart';

/// Languages class used for translations of manually defined strings
class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  Map<String, Map<String, String>> localizedValues = {
    'en': {
      'welcome': 'Welcome',
    },
    'it': {
      'welcome': 'Benvenuto',
    },
  };
}
