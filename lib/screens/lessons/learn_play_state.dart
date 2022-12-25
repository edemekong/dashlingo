import 'package:dashlingo/components/base_state.dart';
import 'package:dashlingo/models/learn/learn.dart';
import 'package:dashlingo/utils/logs.dart';

class LearnPlayState extends BaseState {
  final Learn learn;
  final Function(Answer answer) onNext;
  List<Answer> answers = [];
  Answer? selectedAnswer;

  List<String> fills = [];

  bool validate = false;

  String get correctAnswerId => learn.correctAnswerId;

  Answer? get correctAnswer {
    try {
      return answers.firstWhere((element) => element.id == correctAnswerId);
    } catch (e) {
      edPrint(e);
    }
    return null;
  }

  LearnPlayState(this.learn, this.selectedAnswer, this.onNext) {
    answers = learn.answers;
    if (selectedAnswer != null) {
      onValidate();
    }
  }

  void onSelectAnswer(Answer answer) {
    selectedAnswer = answer;
    notifyListeners();
  }

  void onValidate() {
    if (validate && selectedAnswer != null) {
      onNext(selectedAnswer!);
    }

    validate = true;
    notifyListeners();
  }
}
