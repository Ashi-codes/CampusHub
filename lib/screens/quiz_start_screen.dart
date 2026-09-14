import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'quiz_screen.dart';

class QuizStartScreen extends StatelessWidget {
  const QuizStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;
    final bool isDesktop = size.width >= 1000;

    final double maxWidth = isDesktop
        ? 900
        : isTablet
        ? 750
        : double.infinity;

    final double horizontalPadding = isDesktop
        ? 40
        : isTablet
        ? 32
        : 20;

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            tooltip: "Back",
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.title,
              size: 21,
            ),
          ),
        ),

        title: const Text(
          "Flutter Quiz",
          style: TextStyle(
            color: AppColors.title,
            fontSize: 19,
            fontWeight: FontWeight.w700,
            letterSpacing: -.2,
          ),
        ),

        centerTitle: true,
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                10,
                horizontalPadding,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ==================================================
                  // HERO SECTION
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      isTablet ? 30 : 24,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff1D4ED8),
                          Color(0xff2563EB),
                          Color(0xff4F8DFD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff2563EB)
                              .withOpacity(.20),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [

                        // Decorative circles
                        Positioned(
                          right: -35,
                          top: -40,
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(.08),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 35,
                          bottom: -70,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(.06),
                            ),
                          ),
                        ),

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [

                            // Quiz icon
                            Container(
                              height: isTablet ? 82 : 70,
                              width: isTablet ? 82 : 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.16),
                                borderRadius:
                                BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white.withOpacity(.15),
                                ),
                              ),
                              child: Icon(
                                Icons.quiz_rounded,
                                color: Colors.white,
                                size: isTablet ? 42 : 36,
                              ),
                            ),

                            const SizedBox(width: 18),

                            // Hero text
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                      Colors.white.withOpacity(.14),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "KNOWLEDGE CHECK",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 9),

                                  Text(
                                    "Ready for the Quiz?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      isTablet ? 28 : 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -.4,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  const Text(
                                    "Test your Flutter knowledge\n"
                                        "and challenge yourself.",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // QUIZ STATS
                  // ==================================================

                  Row(
                    children: [

                      Expanded(
                        child: _statCard(
                          icon: Icons.help_outline_rounded,
                          value: "10",
                          label: "Questions",
                          color: const Color(0xff2563EB),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _statCard(
                          icon: Icons.timer_outlined,
                          value: "15s",
                          label: "Per Question",
                          color: const Color(0xffF59E0B),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _statCard(
                          icon: Icons.emoji_events_outlined,
                          value: "1",
                          label: "Final Score",
                          color: const Color(0xff8B5CF6),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // INSTRUCTIONS HEADER
                  // ==================================================

                  Row(
                    children: [

                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.10),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.primary,
                          size: 23,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Before You Start",
                              style: TextStyle(
                                color: AppColors.title,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Keep these quiz rules in mind",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // INSTRUCTIONS CARD
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      isTablet ? 22 : 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xffE8ECF3),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        _instructionRow(
                          number: "01",
                          icon: Icons.touch_app_rounded,
                          title: "Choose one answer",
                          subtitle:
                          "Select the option you believe is correct.",
                          color: const Color(0xff2563EB),
                        ),

                        const SizedBox(height: 16),

                        _divider(),

                        const SizedBox(height: 16),

                        _instructionRow(
                          number: "02",
                          icon: Icons.timer_rounded,
                          title: "Beat the timer",
                          subtitle:
                          "You have 15 seconds for every question.",
                          color: const Color(0xffF59E0B),
                        ),

                        const SizedBox(height: 16),

                        _divider(),

                        const SizedBox(height: 16),

                        _instructionRow(
                          number: "03",
                          icon: Icons.emoji_events_rounded,
                          title: "Aim for the highest score",
                          subtitle:
                          "Your final score will appear after the quiz.",
                          color: const Color(0xff8B5CF6),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  // ==================================================
                  // ATTENTION / TIP
                  // ==================================================

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffEFF6FF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xffDBEAFE),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(11),
                          ),
                          child: const Icon(
                            Icons.lightbulb_rounded,
                            color: Color(0xff2563EB),
                            size: 21,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quick Tip",
                                style: TextStyle(
                                  color: AppColors.title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Read each question carefully before "
                                    "choosing your answer.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.5,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // START BUTTON
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const QuizScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 7,
                        shadowColor:
                        AppColors.primary.withOpacity(.28),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.play_arrow_rounded,
                            size: 27,
                          ),

                          SizedBox(width: 9),

                          Text(
                            "START QUIZ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),

                          SizedBox(width: 8),

                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      "10 questions • 15 seconds each",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // STAT CARD
  // ================================================================

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xffE8ECF3),
        ),
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
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(12),
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
            style: const TextStyle(
              color: AppColors.title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // INSTRUCTION ROW
  // ================================================================

  Widget _instructionRow({
    required String number,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: color,
            size: 23,
          ),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.title,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 7),

                  Text(
                    number,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================================================================
  // DIVIDER
  // ================================================================

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }
}