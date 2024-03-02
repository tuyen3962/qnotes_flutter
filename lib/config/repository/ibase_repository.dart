import 'package:qnotes_flutter/l10n/app_localizations.dart';

abstract class IBaseRepository {
  late AppLocalizations l10n;

  handleError(error) {
    print(error);
  }
}
