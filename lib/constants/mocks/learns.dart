import 'package:dashlingo/data/models/learn/paragraph.dart';

import '../../data/models/learn/learn.dart';

List<Learn> learns = [
  Learn(
    lessonId: 'alshnu0123ef',
    learnId: '-asf34sefe',
    pathLevel: 100,
    learnType: 'play',
    title: "Fill in the blanks",
    instruction: 'Display a String Data-Type on console:',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    content: [
      Paragraph(
        id: '1231',
        index: 0,
        content: 'print(',
        type: 'code',
      ),
      Paragraph(
        id: '434',
        index: 1,
        content: '',
        type: 'fillInBlanks',
      ),
      Paragraph(
        id: '1231',
        index: 2,
        content: ');',
        type: 'code',
      ),
    ],
    answers: [
      Answer(
        id: '123',
        learnId: '-qwerty-',
        content: 'hello, world',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        learnId: '-qwerty-',
        content: '"hello, world"',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        learnId: '-qwerty-',
        content: 'hello, world"',
        type: 'fill',
      ),
    ],
    correctAnswerIds: ['1234'],
    clues: ['Flutter can paint on any screen.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Learn(
    lessonId: '128jsdfs',
    learnId: '-123nsdf',
    pathLevel: 200,
    learnType: 'play',
    title: "Fill in the blanks",
    instruction: 'What command can you use to generate a new Flutter project?',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    content: [
      Paragraph(
        id: '1231',
        index: 0,
        content: 'To create a new Flutter project, you can use the following command:',
        type: 'text',
      ),
      Paragraph(
        id: '434',
        index: 1,
        content: '',
        type: 'fillInBlanks',
      ),
    ],
    answers: [
      Answer(
        id: '123',
        learnId: '-qwerty-',
        content: 'flutter create <project_name>',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        learnId: '-qwerty-',
        content: 'flutter create project',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        learnId: '-qwerty-',
        content: 'flutter run',
        type: 'fill',
      ),
    ],
    correctAnswerIds: ['123'],
    clues: ['Flutter can paint on any screen.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Learn(
    lessonId: 'qwertasdasdy123',
    learnId: '-qwerty-123',
    pathLevel: 100,
    learnType: 'play',
    title: "Fill in the blank",
    instruction: 'How would you display a text on the console?',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    content: [
      Paragraph(
        id: '123456',
        index: 0,
        content: """class User{
  final String name;
  final String email;
  
  const User(this.name, this.email);
}""",
        type: 'code',
      ),
    ],
    answers: [
      Answer(
        id: '123',
        content: '"Hello, World"',
        type: 'fill',
        learnId: '',
      ),
      Answer(
        id: '1234',
        content: '123',
        type: 'fill',
        learnId: '',
      ),
      Answer(
        id: '123456',
        content: '10.34',
        type: 'fill',
        learnId: '',
      ),
    ],
    correctAnswerIds: ['123'],
    clues: ['Flutter can paint on any screen.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Learn(
    lessonId: 'qwerty',
    learnId: '-qwerty-',
    pathLevel: 100,
    learnType: 'play',
    title: "Choose the correct answer",
    instruction: 'Welcome, select the following answer that fixed the list.',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    content: [],
    answers: [
      Answer(
        id: '123',
        learnId: '-qwerty-',
        content: 'True',
        type: 'fill',
      ),
      Answer(
        id: '1234',
        learnId: '-qwerty-',
        content: 'False',
        type: 'fill',
      ),
      Answer(
        id: '123456',
        learnId: '-qwerty-',
        content: 'Non of the above',
        type: 'fill',
      ),
    ],
    correctAnswerIds: ['123'],
    clues: ['A programing language is coding language.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
  Learn(
    lessonId: 'qweasdasdrty123',
    learnId: '-qwerasdty-123',
    pathLevel: 100,
    learnType: 'learn',
    title: "Select the correct answer",
    instruction: 'Try to select the right option from the answers',
    intructor: {
      "uid": "paul123",
      "name": "Paul Jeremiah",
    },
    content: [
      Paragraph(
        id: '',
        index: 0,
        content: 'Flutter has been around for 4 years, evolving from zero to heroo',
        type: 'text',
      ),
    ],
    answers: [],
    correctAnswerIds: ['1234'],
    clues: ['Flutter can paint on any screen.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
];
