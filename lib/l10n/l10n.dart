import 'package:flutter/widgets.dart';
import 'package:base_flutter_source/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
