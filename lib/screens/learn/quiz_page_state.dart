import 'package:flutterfairy/components/base_state.dart';
import 'package:flutterfairy/models/quiz.dart';
import 'package:flutterfairy/utils/logs.dart';

class QuizPageState extends BaseState {
  final Quiz quiz;
  final Function(Answer answer) onNext;
  List<Answer> answers = [];
  Answer? selectedAnswer;

  List<String> fills = [];

  bool validate = false;

  String get correctAnswerId => quiz.correctAnswerId;

  Answer? get correctAnswer {
    try {
      return answers.firstWhere((element) => element.id == correctAnswerId);
    } catch (e) {
      edPrint(e);
    }
    return null;
  }

  QuizPageState(this.quiz, this.selectedAnswer, this.onNext) {
    answers = quiz.answers;
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
