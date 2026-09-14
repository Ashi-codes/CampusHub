import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;
    final bool isDesktop = size.width >= 1000;
    final bool isSmallHeight = size.height < 680;

    final double percentage =
    totalQuestions == 0 ? 0 : score / totalQuestions;

    final int percentageValue = (percentage * 100).round();

    final String resultTitle = _getResultTitle(percentage);
    final String resultMessage = _getResultMessage(percentage);

    final IconData resultIcon = percentage >= 0.7
        ? Icons.emoji_events_rounded
        : percentage >= 0.4
        ? Icons.school_rounded
        : Icons.refresh_rounded;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? 760
                    : isTablet
                    ? 700
                    : double.infinity,
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop
                      ? 45
                      : isTablet
                      ? 40
                      : 22,
                  vertical: isSmallHeight ? 18 : 28,
                ),

                child: Column(
                  children: [

                    // =====================================================
                    // TOP ICON
                    // =====================================================

                    Container(
                      height: isSmallHeight ? 115 : 145,
                      width: isSmallHeight ? 115 : 145,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(.12),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: Container(
                        margin: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          AppColors.primary.withOpacity(.08),
                        ),

                        child: Icon(
                          resultIcon,
                          size: isSmallHeight ? 55 : 68,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: isSmallHeight ? 18 : 25,
                    ),

                    // =====================================================
                    // TITLE
                    // =====================================================

                    Text(
                      resultTitle,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: isTablet ? 34 : 29,
                        fontWeight: FontWeight.w800,
                        color: AppColors.title,
                        letterSpacing: -.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      resultMessage,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: isTablet ? 17 : 15,
                        color: Colors.grey.shade600,
                        height: 1.45,
                      ),
                    ),

                    SizedBox(
                      height: isSmallHeight ? 22 : 32,
                    ),

                    // =====================================================
                    // SCORE CARD
                    // =====================================================

                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.all(
                        isSmallHeight ? 22 : 28,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          // SCORE LABEL
                          Text(
                            "FINAL SCORE",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.4,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // SCORE
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.baseline,
                            textBaseline:
                            TextBaseline.alphabetic,

                            children: [
                              Text(
                                "$score",
                                style: TextStyle(
                                  fontSize:
                                  isSmallHeight ? 46 : 58,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  height: 1,
                                ),
                              ),

                              Text(
                                " / $totalQuestions",
                                style: TextStyle(
                                  fontSize:
                                  isSmallHeight ? 22 : 27,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // PERCENTAGE
                          Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),

                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(.08),
                              borderRadius:
                              BorderRadius.circular(30),
                            ),

                            child: Text(
                              "$percentageValue% Accuracy",
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // PROGRESS
                          Align(
                            alignment: Alignment.centerLeft,

                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,

                              children: [
                                const Text(
                                  "Quiz Performance",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.title,
                                  ),
                                ),

                                Text(
                                  "$percentageValue%",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(20),

                            child: LinearProgressIndicator(
                              value: percentage.clamp(0.0, 1.0),
                              minHeight: 9,

                              backgroundColor:
                              Colors.grey.shade200,

                              valueColor:
                              const AlwaysStoppedAnimation<
                                  Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: isSmallHeight ? 22 : 30,
                    ),

                    // =====================================================
                    // PERFORMANCE SUMMARY
                    // =====================================================

                    Row(
                      children: [

                        Expanded(
                          child: _summaryCard(
                            icon: Icons.check_circle_rounded,
                            title: "Correct",
                            value: "$score",
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _summaryCard(
                            icon: Icons.cancel_rounded,
                            title: "Incorrect",
                            value:
                            "${totalQuestions - score}",
                            color: Colors.red,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _summaryCard(
                            icon: Icons.quiz_rounded,
                            title: "Total",
                            value: "$totalQuestions",
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: isSmallHeight ? 25 : 35,
                    ),

                    // =====================================================
                    // RESTART BUTTON
                    // =====================================================

                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const QuizScreen(),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primary,

                          foregroundColor: Colors.white,

                          elevation: 7,

                          shadowColor:
                          AppColors.primary
                              .withOpacity(.25),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(18),
                          ),
                        ),

                        child: const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 23,
                            ),

                            SizedBox(width: 9),

                            Text(
                              "RESTART QUIZ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w800,
                                letterSpacing: .3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =====================================================
                    // BACK BUTTON
                    // =====================================================

                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 18,
                      ),

                      label: const Text(
                        "Back to Quiz Start",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      style: TextButton.styleFrom(
                        foregroundColor:
                        AppColors.primary,
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // RESULT TITLE
  // ===============================================================

  String _getResultTitle(double percentage) {
    if (percentage >= 0.9) {
      return "Outstanding! 🎉";
    }

    if (percentage >= 0.7) {
      return "Excellent Work! 👏";
    }

    if (percentage >= 0.4) {
      return "Good Effort! 💪";
    }

    return "Keep Practicing! 🚀";
  }

  // ===============================================================
  // RESULT MESSAGE
  // ===============================================================

  String _getResultMessage(double percentage) {
    if (percentage >= 0.9) {
      return "You've mastered this quiz. Amazing performance!";
    }

    if (percentage >= 0.7) {
      return "Great job! Your Flutter knowledge is looking strong.";
    }

    if (percentage >= 0.4) {
      return "You're making progress. Keep learning and try again!";
    }

    return "Don't worry. Practice more and you'll improve quickly!";
  }

  // ===============================================================
  // SUMMARY CARD
  // ===============================================================

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [

          Container(
            height: 38,
            width: 38,

            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius:
              BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            value,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}