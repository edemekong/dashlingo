import 'package:dashlingo/models/learn/paragraph.dart';

import '../../models/learn/learn.dart';

List<Learn> learns = [
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
    correctAnswerId: '123',
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
    correctAnswerId: '123',
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
    correctAnswerId: '1234',
    clues: ['Flutter can paint on any screen.'],
    createdAt: 123234234,
    updatedAt: 9834098534,
  ),
];
