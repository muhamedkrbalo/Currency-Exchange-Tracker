import 'package:easy_localization/easy_localization.dart';

import '../../core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  final apiMessage = failure.apiMessage?.trim();
  final canShowApiMessage = failure is ValidationFailure;

  if (canShowApiMessage && apiMessage != null && apiMessage.isNotEmpty) {
    return apiMessage;
  }
  return failure.messageKey.tr();
}
