

import '../../global/ui/utils/dialog_util.dart';
import 'app_exceptions.dart';

class ErrorHandler {
  void handleError(error) {
    if (error is BadRequestException) {
        var message = error.message;
        DialogUtil.showErrorDialog(message!);
    } else if (error is FetchDataException) {
        var message = error.message;
        DialogUtil.showErrorDialog(message!);
    } else if (error is ApiNotRespondingException) {
        DialogUtil.showErrorDialog('Oops! It take too longer to respond');
    }
  }
}