import 'package:dashlingo/constants/mocks/lessons.dart';

import '../../models/learn/lesson.dart';
import '../../models/learn/step.dart';

List<DashStep> steps = [
  const DashStep(
    id: 'step-1',
    title: 'DashStep 1',
    description: 'Start with the basics',
    createdAt: 123,
    updatedAt: 123,
    totalLessons: 3,
    author: {
      "uid": "123123",
      "name": "Paul Jeremiah",
    },
    lessons: lessons,
    verson: '0.0.1',
    level: '1',
    tutorialId: '-123-',
    dashes: [],
    coverImage: '',
  ),
  const DashStep(
    id: 'step-2',
    title: 'DashStep 2',
    description: 'Understand Dart conditionals',
    createdAt: 123,
    updatedAt: 123,
    totalLessons: 3,
    author: {
      "uid": "123123",
      "name": "Paul Jeremiah",
    },
    lessons: [
      ...lessons,
      Lesson(
        id: '-123-345-678-',
        title: 'Conditional ',
        description: 'Learn conditions',
        createdAt: 123,
        updatedAt: 123,
      ),
    ],
    verson: '0.0.1',
    level: '1',
    tutorialId: '-123-',
    dashes: [],
    coverImage: '',
  ),
  const DashStep(
    id: 'step-3',
    title: 'DashStep 3',
    description: 'Dart collections',
    createdAt: 123,
    updatedAt: 123,
    totalLessons: 3,
    author: {
      "uid": "123123",
      "name": "Paul Jeremiah",
    },
    lessons: lessons,
    verson: '0.0.1',
    level: '1',
    tutorialId: '-123-',
    dashes: [],
    coverImage: '',
  ),
];
