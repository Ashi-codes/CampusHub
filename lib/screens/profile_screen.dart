import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          child: Column(
            children: [

              // =========================
              // HEADER
              // =========================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.title,
                    ),
                  ),

                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // =========================
              // PROFILE CARD
              // =========================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff0F52FF),
                      Color(0xff4F8DFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(25),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    // PROFILE IMAGE

                    Container(
                      height: 90,
                      width: 90,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),

                      child: const Icon(
                        Icons.person_rounded,
                        size: 55,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Ayesha",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      "BS Software Engineering",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "CampusHub Student",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // ACADEMIC INFORMATION
              // =========================

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Academic Information",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [

                  Expanded(
                    child: _infoCard(
                      icon: Icons.school_outlined,
                      title: "Program",
                      value: "BSSE",
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _infoCard(
                      icon: Icons.calendar_month_outlined,
                      title: "Semester",
                      value: "7th",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: _infoCard(
                      icon: Icons.menu_book_outlined,
                      title: "Courses",
                      value: "6",
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _infoCard(
                      icon: Icons.quiz_outlined,
                      title: "Quizzes",
                      value: "10",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =========================
              // ACCOUNT
              // =========================

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _menuTile(
                icon: Icons.person_outline,
                title: "Personal Information",
                subtitle: "Manage your profile details",
                onTap: () {},
              ),

              _menuTile(
                icon: Icons.menu_book_outlined,
                title: "My Courses",
                subtitle: "View your enrolled courses",
                onTap: () {},
              ),

              _menuTile(
                icon: Icons.emoji_events_outlined,
                title: "Quiz Results",
                subtitle: "Check your quiz performance",
                onTap: () {},
              ),

              _menuTile(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                subtitle: "Manage your notifications",
                onTap: () {},
              ),

              _menuTile(
                icon: Icons.settings_outlined,
                title: "Settings",
                subtitle: "App preferences and settings",
                onTap: () {},
              ),

              const SizedBox(height: 15),

              // =========================
              // LOGOUT BUTTON
              // =========================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: OutlinedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },

                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),

                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.red.shade200,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // VERSION
              // =========================

              const Text(
                "CampusHub • Version 1.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // INFORMATION CARD
  // =========================

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),

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

      child: Row(
        children: [

          Container(
            height: 42,
            width: 42,

            decoration: BoxDecoration(
              color: const Color(0xffEEF4FF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.title,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // MENU TILE
  // =========================

  static Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),

        leading: Container(
          height: 44,
          width: 44,

          decoration: BoxDecoration(
            color: const Color(0xffEEF4FF),
            borderRadius: BorderRadius.circular(13),
          ),

          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  // =========================
  // LOGOUT DIALOG
  // =========================

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            "Logout?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            "Are you sure you want to logout?",
          ),

          actions: [

            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),

            // LOGOUT
            ElevatedButton(
              onPressed: () {
                // Close dialog first
                Navigator.pop(dialogContext);

                // Remove MainNavigation from history
                // and open Login Screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),

              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}