import 'package:flutterfairy/models/quiz.dart';

List<Quiz> quizData = const [
  Quiz(
    lessonId: 'qwertasdasdy123',
    quizId: '-qwerty-123',
    pathType: 'beginner',
    pathLevel: 100,
    quizType: 'play',
    title: "Fill in the blank",
    instruction: 'How would you display a text on the console?',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    question: Question(
      id: "",
      quizId: '-qwerty-123123',
      questionType: QuestionType.fillInTheBlank,
      content: 'void main() => print("/blank");',
      linkToLesson: "",
    ),
    answers: [
      Answer(
        id: '123',
        quizId: '-qwerty-',
        content: '"Hello, World"',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        quizId: '-qwerty-',
        content: '123',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        quizId: '-qwerty-',
        content: '10.34',
        type: 'fill',
      ),
    ],
    correctAnswerId: '123',
    clue: 'Flutter can paint on any screen.',
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Quiz(
    lessonId: 'qwerty',
    quizId: '-qwerty-',
    pathType: 'beginner',
    pathLevel: 100,
    quizType: 'play',
    title: "Choose the correct answer",
    instruction: 'Welcome, select the following answer that fixed the list.',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    question: Question(
      id: "",
      quizId: '-qwerty-',
      questionType: QuestionType.conditional,
      content: 'Dart is a programing language?',
      linkToLesson: "",
    ),
    answers: [
      Answer(
        id: '123',
        quizId: '-qwerty-',
        content: 'True',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        quizId: '-qwerty-',
        content: 'False',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        quizId: '-qwerty-',
        content: 'Non of the above',
        type: 'fill',
      ),
    ],
    correctAnswerId: '123',
    clue: 'A programing language is coding language.',
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Quiz(
    lessonId: 'qweasdasdrty123',
    quizId: '-qwerasdty-123',
    pathType: 'beginner',
    pathLevel: 100,
    quizType: 'learn',
    title: "Select the correct answer",
    instruction: 'Try to select the right option from the answers',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    question: Question(
      id: "",
      quizId: '-qwerty-123123',
      questionType: QuestionType.conditional,
      content: 'Is NOT a Flutter a cross-platform SDK tool?',
      linkToLesson: "",
    ),
    answers: [
      Answer(
        id: '123',
        quizId: '-qwerty-',
        content: 'True',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        quizId: '-qwerty-',
        content: 'False',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        quizId: '-qwerty-',
        content: 'Non of the above',
        type: 'fill',
      ),
    ],
    correctAnswerId: '1234',
    clue: 'Flutter can paint on any screen.',
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
];