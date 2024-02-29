import 'package:base_flutter_source/l10n/app_localizations.dart';

abstract class IBaseRepository {
  late AppLocalizations l10n;

  handleError(error) {
    print(error);
  }
}
