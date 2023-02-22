import 'package:dashlingo/components/base_state.dart';
import 'package:dashlingo/models/learn/learn.dart';
import 'package:dashlingo/utils/logs.dart';

class LearnPlayState extends BaseState {
  late Learn learn;

  final Function(Answer answer) onNext;
  List<Answer> answers = [];
  Answer? selectedAnswer;

  List<String> fills = [];

  bool validate = false;

  List<String> get correctAnswerIds => learn.correctAnswerIds;

  Answer? get correctAnswer {
    try {
      return answers.firstWhere((element) => correctAnswerIds.contains(element.id));
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
    for (var element in learn.content) {
      if (element.type == 'fillInBlanks') {
        final newParagraph = element.copyWith(
          fill: [answer.content],
        );
        var indexWhere = learn.content.indexWhere((x) => x.id == element.id);
        learn.content.removeAt(indexWhere);
        learn.content.insert(indexWhere, newParagraph);
      }
    }
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
