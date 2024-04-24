import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/Model/Question_model.dart';
import 'package:quize_app/View/result_screen/result_screen.dart';
import 'package:quize_app/View/welcome_screen.dart';

class QuizController extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(
      id: 1,
      question: "Best Channel for Flutter ",
      answer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 1,
      options: ['mohamed', 'Abdo ', 'ahmed ', 'sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Abdo is",
      answer: 1,
      options: ['Doc', 'eng', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question: "Best Rapper in Egypt",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Real Name of Abdo",
      answer: 1,
      options: ['Abdelrahman ', 'Abdelftah ', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Abdo love",
      answer: 2,
      options: ['Html', 'Java', 'Flutter', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question: "Colores Love",
      answer: 1,
      options: [
        'Red',
        'Black',
        'Green',
        'None of above '
      ],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  bool _isPress = false;
  double _numberOfQuestion = 1;
  int? _selectAnswer;
  int _countOfCorrectQuestion = 0;
  final RxInt _sec = 15.obs;

  int get countOfQuestin => _questionList.length;
  List<QuestionModel> get questionList => [..._questionList];
  int get countOfCorrectQuestion => _countOfCorrectQuestion;
  bool get isPress => _isPress;
  double get numberOfQuestion => _numberOfQuestion;
  int? get selectAnswer => _selectAnswer;
  RxInt get sec => _sec;

  int? _corectAnswer;
  Map<int, bool> questionIsAnswer = {};
  int maxsec = 15;
  Timer? _timer;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    restAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return _countOfCorrectQuestion * 100 / _questionList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selctedAnswerd) {
    _isPress = true;

    _selectAnswer = selctedAnswerd;
    _corectAnswer = questionModel.answer;
    if (_corectAnswer == _selectAnswer) {
      _countOfCorrectQuestion ++;
    }
    stopTimer();
    questionIsAnswer.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  // ignore: non_constant_identifier_names
  bool checkQuestionIsAnswer(int QusId) {
    return questionIsAnswer.entries
        .firstWhere((element) => element.key == QusId)
        .value;
  }

  void restAnswer() {
    for (var element in _questionList) {
      questionIsAnswer.addAll({element.id: false});
    }
    update();
  }

  nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionList.length -1 ) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPress = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }
    _numberOfQuestion = pageController.page! +2;
    update();
  }

  Color getColor(int answerIndex) {
    if (_isPress) {
      if (_corectAnswer == answerIndex) {
        return Colors.green;
      } else if (_selectAnswer == answerIndex &&
          _corectAnswer != _selectAnswer) {
        return Colors.red;
      }
    }

    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPress) {
      if (_corectAnswer == answerIndex) {
        return Icons.done;
      } else if (_selectAnswer == answerIndex &&
          _corectAnswer != _selectAnswer) {
        return Icons.close;
      }
    }

    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (sec.value > 0) {
        sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void stopTimer() => _timer!.cancel();

  void resetTimer() => _sec.value = maxsec;

  void startAgain() {
    _corectAnswer = null;
    _countOfCorrectQuestion = 0;
    restAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
