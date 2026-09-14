import 'dart:async';

import 'package:flutter/material.dart';

import '../data/quiz_questions.dart';
import '../utils/app_colors.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  static const int questionDuration = 15;

  int currentQuestionIndex = 0;
  int score = 0;
  int remainingSeconds = questionDuration;

  Timer? _timer;

  int? selectedAnswer;
  bool answerLocked = false;

  late AnimationController _flashController;
  late Animation<double> _flashAnimation;

  @override
  void initState() {
    super.initState();

    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _flashAnimation = CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeOut,
    );

    _startTimer();
  }

  // ============================================================
  // TIMER
  // ============================================================

  void _startTimer() {
    _timer?.cancel();

    setState(() {
      remainingSeconds = questionDuration;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (remainingSeconds > 1) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          timer.cancel();
          _handleTimeUp();
        }
      },
    );
  }

  // ============================================================
  // TIME UP
  // ============================================================

  void _handleTimeUp() {
    if (answerLocked) return;

    setState(() {
      answerLocked = true;
      selectedAnswer = null;
    });

    _triggerFlash(isCorrect: false);

    Future.delayed(
      const Duration(milliseconds: 700),
          () {
        if (!mounted) return;
        _moveToNextQuestion();
      },
    );
  }

  // ============================================================
  // SELECT ANSWER
  // ============================================================

  void _selectAnswer(int index) {
    if (answerLocked) return;

    final correctAnswer =
        quizQuestions[currentQuestionIndex].correctAnswer;

    final bool isCorrect = index == correctAnswer;

    _timer?.cancel();

    setState(() {
      selectedAnswer = index;
      answerLocked = true;

      if (isCorrect) {
        score++;
      }
    });

    _triggerFlash(isCorrect: isCorrect);

    Future.delayed(
      const Duration(milliseconds: 850),
          () {
        if (!mounted) return;
        _moveToNextQuestion();
      },
    );
  }

  // ============================================================
  // FLASH ANIMATION
  // ============================================================

  void _triggerFlash({
    required bool isCorrect,
  }) {
    _flashController.forward(from: 0);
  }

  // ============================================================
  // NEXT QUESTION
  // ============================================================

  void _moveToNextQuestion() {
    if (!mounted) return;

    _timer?.cancel();

    if (currentQuestionIndex <
        quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        answerLocked = false;
      });

      _startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score: score,
            totalQuestions: quizQuestions.length,
          ),
        ),
      );
    }
  }

  // ============================================================
  // BACK BUTTON
  // ============================================================

  Future<void> _handleBackButton() async {
    if (!mounted) return;

    _timer?.cancel();

    final shouldLeave = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          titlePadding: const EdgeInsets.fromLTRB(
            24,
            24,
            24,
            8,
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            10,
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            16,
            4,
            16,
            16,
          ),
          title: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.red.shade600,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Leave Quiz?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            "Your current progress will be lost if you leave the quiz now.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                "Stay",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Leave Quiz",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (shouldLeave == true) {
      Navigator.pop(context);
    } else {
      _startTimer();
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _timer?.cancel();
    _flashController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;
    final bool isDesktop = size.width >= 1000;

    final double maxWidth = isDesktop
        ? 900
        : isTablet
        ? 760
        : double.infinity;

    final double horizontalPadding = isDesktop
        ? 35
        : isTablet
        ? 30
        : 20;

    final question =
    quizQuestions[currentQuestionIndex];

    final double progress =
        (currentQuestionIndex + 1) /
            quizQuestions.length;

    final bool isUrgent = remainingSeconds <= 5;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBackButton();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF7F9FC),

        // ========================================================
        // APP BAR
        // ========================================================

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 64,
          titleSpacing: horizontalPadding,
          title: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.quiz_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Flutter Quiz",
                      style: TextStyle(
                        color: AppColors.title,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Test your knowledge",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "${currentQuestionIndex + 1}/${quizQuestions.length}",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ========================================================
        // BODY
        // ========================================================

        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    8,
                    horizontalPadding,
                    35,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      // ==================================================
                      // PROGRESS
                      // ==================================================

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quiz Progress",
                            style: TextStyle(
                              color: AppColors.title,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Text(
                            "${(progress * 100).round()}%",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor:
                          Colors.grey.shade200,
                          valueColor:
                          const AlwaysStoppedAnimation<
                              Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // TIMER
                      // ==================================================

                      Center(
                        child: AnimatedContainer(
                          duration:
                          const Duration(milliseconds: 250),
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isUrgent
                                ? Colors.red.shade50
                                : Colors.white,
                            borderRadius:
                            BorderRadius.circular(30),
                            border: Border.all(
                              color: isUrgent
                                  ? Colors.red.shade100
                                  : Colors.grey.shade200,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize:
                            MainAxisSize.min,
                            children: [
                              Icon(
                                isUrgent
                                    ? Icons.timer_rounded
                                    : Icons.timer_outlined,
                                color: isUrgent
                                    ? Colors.red.shade600
                                    : AppColors.primary,
                                size: 22,
                              ),

                              const SizedBox(width: 8),

                              Text(
                                "00:${remainingSeconds.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  color: isUrgent
                                      ? Colors.red.shade600
                                      : AppColors.title,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(width: 7),

                              Text(
                                "remaining",
                                style: TextStyle(
                                  color: isUrgent
                                      ? Colors.red.shade400
                                      : Colors.grey.shade500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // QUESTION CARD
                      // ==================================================

                      _buildQuestionCard(
                        question.question,
                        isTablet,
                      ),

                      const SizedBox(height: 25),

                      // ==================================================
                      // ANSWER HEADER
                      // ==================================================

                      Row(
                        children: [
                          const Text(
                            "Choose your answer",
                            style: TextStyle(
                              color: AppColors.title,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          if (!answerLocked)
                            Text(
                              "Select one",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ==================================================
                      // OPTIONS
                      // ==================================================

                      ...List.generate(
                        question.options.length,
                            (index) {
                          return _buildOption(
                            option:
                            question.options[index],
                            index: index,
                            correctAnswer:
                            question.correctAnswer,
                          );
                        },
                      ),

                      const SizedBox(height: 5),

                      // ==================================================
                      // FOOTER
                      // ==================================================

                      if (!answerLocked)
                        Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10),
                            child: Text(
                              "Select an option to continue",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // QUESTION CARD
  // ============================================================

  Widget _buildQuestionCard(
      String question,
      bool isTablet,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isTablet ? 30 : 24,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff2563EB),
            Color(0xff4F8DFD),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.20),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            question,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 24 : 20,
              height: 1.45,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Question ${currentQuestionIndex + 1}",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OPTION
  // ============================================================

  Widget _buildOption({
    required String option,
    required int index,
    required int correctAnswer,
  }) {
    final bool isSelected =
        selectedAnswer == index;

    final bool isCorrect =
        index == correctAnswer;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey.shade200;
    Color accentColor = AppColors.primary;
    Color textColor = AppColors.title;

    IconData trailingIcon =
        Icons.radio_button_unchecked_rounded;

    if (answerLocked) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade50;
        borderColor = Colors.green.shade400;
        accentColor = Colors.green.shade600;
        trailingIcon =
            Icons.check_circle_rounded;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade50;
        borderColor = Colors.red.shade400;
        accentColor = Colors.red.shade600;
        trailingIcon = Icons.cancel_rounded;
      } else {
        backgroundColor = Colors.grey.shade50;
        borderColor = Colors.grey.shade200;
        accentColor = Colors.grey.shade400;
        textColor = Colors.grey.shade500;
        trailingIcon =
            Icons.radio_button_unchecked_rounded;
      }
    } else if (isSelected) {
      backgroundColor =
      const Color(0xffEEF4FF);
      borderColor = AppColors.primary;
      accentColor = AppColors.primary;
      trailingIcon =
          Icons.radio_button_checked_rounded;
    }

    return AnimatedContainer(
      duration:
      const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      margin:
      const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: isSelected || isCorrect
              ? 1.6
              : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
          BorderRadius.circular(20),
          onTap: answerLocked
              ? null
              : () => _selectAnswer(index),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [

                // OPTION LETTER
                AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 200),
                  height: 42,
                  width: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                    accentColor.withOpacity(.10),
                    borderRadius:
                    BorderRadius.circular(13),
                  ),
                  child: Text(
                    String.fromCharCode(
                      65 + index,
                    ),
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // OPTION TEXT
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15.5,
                      height: 1.35,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // STATUS ICON
                Icon(
                  trailingIcon,
                  color: accentColor,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}