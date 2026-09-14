import '../models/question_model.dart';

const List<Question> quizQuestions = [

  Question(
    question: "Flutter is developed by which company?",
    options: [
      "Microsoft",
      "Google",
      "Apple",
      "Meta",
    ],
    correctAnswer: 1,
  ),

  Question(
    question: "Which programming language is used by Flutter?",
    options: [
      "Java",
      "Kotlin",
      "Dart",
      "Swift",
    ],
    correctAnswer: 2,
  ),

  Question(
    question: "What is the basic building block of a Flutter UI?",
    options: [
      "Widget",
      "Activity",
      "Fragment",
      "Component",
    ],
    correctAnswer: 0,
  ),

  Question(
    question: "Which command runs a Flutter application?",
    options: [
      "flutter start",
      "flutter run",
      "flutter launch",
      "flutter execute",
    ],
    correctAnswer: 1,
  ),

  Question(
    question: "Which widget is used for a vertical layout?",
    options: [
      "Row",
      "Stack",
      "Column",
      "ListTile",
    ],
    correctAnswer: 2,
  ),

  Question(
    question: "Which widget is used for a horizontal layout?",
    options: [
      "Column",
      "Row",
      "Stack",
      "Container",
    ],
    correctAnswer: 1,
  ),

  Question(
    question: "Which widget is commonly used to make a screen scrollable?",
    options: [
      "SingleChildScrollView",
      "SizedBox",
      "Center",
      "Expanded",
    ],
    correctAnswer: 0,
  ),

  Question(
    question: "Which method is used to update StatefulWidget UI?",
    options: [
      "updateState()",
      "refresh()",
      "setState()",
      "changeState()",
    ],
    correctAnswer: 2,
  ),

  Question(
    question: "Which file contains Flutter project dependencies?",
    options: [
      "main.dart",
      "pubspec.yaml",
      "AndroidManifest.xml",
      "settings.dart",
    ],
    correctAnswer: 1,
  ),

  Question(
    question: "Which widget is used for a button with Material design?",
    options: [
      "Text",
      "Container",
      "ElevatedButton",
      "Padding",
    ],
    correctAnswer: 2,
  ),
];