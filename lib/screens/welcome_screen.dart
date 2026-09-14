import 'package:flutter/material.dart';

import 'register_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_textstyles.dart';
import 'login_screen.dart';
import '../widgets/background_effect.dart';
import '../widgets/curved_container.dart';
import '../widgets/dotted_pattern.dart';
import '../widgets/star_icon.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive values
    final bool isSmallScreen = size.height < 700;
    final bool isWideScreen = size.width > 700;

    final double imageHeight = isWideScreen
        ? size.height * 0.30
        : isSmallScreen
        ? size.height * 0.36
        : size.height * 0.40;

    final double containerTop = isWideScreen
        ? size.height * 0.39
        : isSmallScreen
        ? size.height * 0.30
        : size.height * 0.33;

    final double horizontalPadding = isWideScreen
        ? 70
        : size.width < 360
        ? 18
        : 30;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Stack(
          children: [

            // =========================
            // BACKGROUND
            // =========================

            const BackgroundEffect(),

            // =========================
            // TOP IMAGE
            // =========================

            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: Image.asset(
                "assets/images/welcome.jpg",
                fit: BoxFit.cover,
              ),
            ),

            // =========================
            // LEFT STAR
            // =========================

            Positioned(
              top: isSmallScreen ? 55 : 85,
              left: isWideScreen ? 60 : 28,
              child: const StarIcon(),
            ),

            // =========================
            // RIGHT STAR
            // =========================

            Positioned(
              top: isSmallScreen ? 80 : 120,
              right: isWideScreen ? 60 : 28,
              child: const StarIcon(),
            ),

            // =========================
            // LEFT DOTS
            // =========================

            Positioned(
              left: isWideScreen ? 35 : 18,
              top: isSmallScreen ? 190 : 255,
              child: const DottedPattern(),
            ),

            // =========================
            // RIGHT DOTS
            // =========================

            Positioned(
              right: isWideScreen ? 35 : 18,
              top: isSmallScreen ? 390 : 560,
              child: const DottedPattern(),
            ),

            // =========================
            // BOTTOM LEFT DOTS
            // =========================

            Positioned(
              left: isWideScreen ? 35 : 18,
              bottom: 20,
              child: const DottedPattern(),
            ),

            // =========================
            // WHITE CURVED CONTAINER
            // =========================

            Positioned(
              top: containerTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: CurvedContainer(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    isSmallScreen ? 12 : 20,
                    horizontalPadding,
                    60,
                  ),

                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 850 : double.infinity,
                    ),

                    child: Column(
                      children: [

                        SizedBox(
                          height: isSmallScreen ? 25 : 45,
                        ),

                        // =========================
                        // WELCOME
                        // =========================

                        Text(
                          "Welcome to",
                          style: AppTextStyles.welcome,
                        ),

                        const SizedBox(height: 12),

                        // =========================
                        // CAMPUS HUB
                        // =========================

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const StarIcon(),

                              const SizedBox(width: 10),

                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Campus",
                                      style: AppTextStyles.campusHub.copyWith(
                                        color: const Color(0xff0F1E6E),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Hub",
                                      style: AppTextStyles.campusHub.copyWith(
                                        color: const Color(0xff2563EB),
                                      ),
                                    ),
                                  ],
                                ),
                                softWrap: false,
                                maxLines: 1,
                              ),

                              const SizedBox(width: 10),

                              const StarIcon(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // =========================
                        // TAGLINE
                        // =========================

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color:
                                AppColors.secondary.withOpacity(.4),
                                thickness: 2,
                              ),
                            ),

                            Flexible(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "Your Smart Campus Companion",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                    size.width < 360 ? 12 : 14,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Divider(
                                color:
                                AppColors.secondary.withOpacity(.4),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // =========================
                        // DESCRIPTION
                        // =========================

                        Text(
                          "Manage assignments, attendance,\n"
                              "courses and campus life all in one place.",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body,
                        ),

                        SizedBox(
                          height: isSmallScreen ? 25 : 40,
                        ),

                        // =========================
                        // LOGIN BUTTON
                        // =========================

                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 8,
                              shadowColor: AppColors.shadow,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =========================
                        // CREATE ACCOUNT
                        // =========================

                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const RegisterScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.person_add_alt_1,
                                  color: AppColors.primary,
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "CREATE ACCOUNT",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // =========================
                        // OR CONTINUE
                        // =========================

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(),
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                "OR CONTINUE WITH",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                  size.width < 360 ? 11 : 13,
                                ),
                              ),
                            ),

                            const Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: StarIcon(),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // =========================
                        // SOCIAL BUTTONS
                        // =========================

                        Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.red,
                                      size: 40,
                                    ),

                                    SizedBox(width: 8),

                                    Flexible(
                                      child: Text(
                                        "Google",
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.facebook,
                                      color: Color(0xff1877F2),
                                      size: 30,
                                    ),

                                    SizedBox(width: 8),

                                    Flexible(
                                      child: Text(
                                        "Facebook",
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: isSmallScreen ? 30 : 45,
                        ),

                        // =========================
                        // VERIFIED
                        // =========================

                        const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.primary,
                          size: 32,
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "By continuing you agree to our",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff667085),
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff667085),
                            ),
                            children: [
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text: "  and  ",
                              ),

                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: const [
                            StarIcon(),
                            SizedBox(width: 30),
                            StarIcon(),
                          ],
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}