import 'package:flutter/foundation.dart';

class QuestionnaireModel with ChangeNotifier {
  double currentTitlePage = 0, currentCardPage = 0;

  void setCurrentPage(double page, {bool card = true}) {
    card ? currentCardPage = page : currentTitlePage = page;

    notifyListeners();
  }
}
