import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'home_screen.dart';
import 'courses_screen.dart';
import 'schedule_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    CoursesScreen(),
    ScheduleScreen(),
    ProfileScreen(),
  ];

  void changeScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 1000;

    // ============================================================
    // DESKTOP / LAPTOP
    // ============================================================

    if (isDesktop) {
      return Scaffold(
        backgroundColor: const Color(0xffF7F9FC),

        body: Row(
          children: [

            // ======================================================
            // DESKTOP SIDE NAVIGATION
            // ======================================================

            Container(
              width: 230,
              margin: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),

                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: SafeArea(
                child: Column(
                  children: [

                    const SizedBox(height: 25),

                    // LOGO
                    Container(
                      height: 60,
                      width: 60,

                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.10),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.school_rounded,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "CampusHub",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColors.title,
                      ),
                    ),

                    const SizedBox(height: 35),

                    // HOME
                    _desktopNavItem(
                      icon: Icons.home_rounded,
                      title: "Home",
                      index: 0,
                    ),

                    // COURSES
                    _desktopNavItem(
                      icon: Icons.book_rounded,
                      title: "Courses",
                      index: 1,
                    ),

                    // SCHEDULE
                    _desktopNavItem(
                      icon: Icons.calendar_month_rounded,
                      title: "Schedule",
                      index: 2,
                    ),

                    // PROFILE
                    _desktopNavItem(
                      icon: Icons.person_rounded,
                      title: "Profile",
                      index: 3,
                    ),

                    const Spacer(),

                    // USER
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: const Color(0xffF7F9FC),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Row(
                        children: [

                          CircleAvatar(
                            radius: 21,
                            backgroundColor:
                            AppColors.primary.withOpacity(.12),

                            child: const Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(width: 10),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Ayesha",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.title,
                                  ),
                                ),

                                SizedBox(height: 2),

                                Text(
                                  "Student",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ======================================================
            // ACTUAL SCREEN CONTENT
            // ======================================================

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 18,
                  right: 18,
                  bottom: 18,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xffF7F9FC),
                  borderRadius: BorderRadius.circular(25),
                ),

                clipBehavior: Clip.antiAlias,

                child: IndexedStack(
                  index: currentIndex,
                  children: screens,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ============================================================
    // MOBILE / TABLET
    // ============================================================

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      // ==========================================================
      // ONLY ONE BOTTOM NAVIGATION
      // ==========================================================

      bottomNavigationBar: SafeArea(
        top: false,

        child: Container(
          margin: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            12,
          ),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),

            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 18,
                offset: Offset(0, 5),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),

            child: BottomNavigationBar(
              currentIndex: currentIndex,

              onTap: changeScreen,

              type: BottomNavigationBarType.fixed,

              backgroundColor: Colors.white,

              elevation: 0,

              selectedItemColor: AppColors.primary,

              unselectedItemColor: Colors.grey,

              selectedFontSize: 14,

              unselectedFontSize: 14,

              showUnselectedLabels: true,

              items: const [

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                  ),
                  label: "Home",
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_rounded,
                  ),
                  label: "Courses",
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month_rounded,
                  ),
                  label: "Schedule",
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_rounded,
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP NAV ITEM
  // ============================================================

  Widget _desktopNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          changeScreen(index);
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),

          width: double.infinity,

          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withOpacity(.10)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(16),
          ),

          child: Row(
            children: [

              Icon(
                icon,

                color: selected
                    ? AppColors.primary
                    : Colors.grey,

                size: 24,
              ),

              const SizedBox(width: 14),

              Text(
                title,

                style: TextStyle(
                  color: selected
                      ? AppColors.primary
                      : Colors.grey,

                  fontSize: 15,

                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}