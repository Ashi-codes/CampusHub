import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;
    final bool isDesktop = size.width >= 1000;

    final double maxContentWidth = isDesktop
        ? 1100
        : isTablet
        ? 850
        : double.infinity;

    final double horizontalPadding = isDesktop
        ? 30
        : isTablet
        ? 28
        : 22;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      body: Stack(
        children: [
          // ============================================================
          // BACKGROUND
          // ============================================================

          const BackgroundEffect(),

          // ============================================================
          // MAIN CONTENT
          // ============================================================

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 18,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // HEADER
                        // ==================================================

                        Text(
                          "My Schedule",
                          style: TextStyle(
                            fontSize: isTablet ? 32 : 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.title,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Manage your classes and daily activities",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: isTablet ? 17 : 15,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ==================================================
                        // TODAY CARD
                        // ==================================================

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff2563EB),
                                Color(0xff4F8DFD),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(.25),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Date
                              Container(
                                height: 68,
                                width: 68,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                                child: const Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "AUG",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 16),

                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Wednesday",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "3 classes scheduled",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius:
                                  BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // WEEK DAYS
                        // ==================================================

                        sectionTitle("This Week"),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 82,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              dayCard(
                                day: "Mon",
                                date: "10",
                                selected: false,
                              ),
                              dayCard(
                                day: "Tue",
                                date: "11",
                                selected: false,
                              ),
                              dayCard(
                                day: "Wed",
                                date: "12",
                                selected: true,
                              ),
                              dayCard(
                                day: "Thu",
                                date: "13",
                                selected: false,
                              ),
                              dayCard(
                                day: "Fri",
                                date: "14",
                                selected: false,
                              ),
                              dayCard(
                                day: "Sat",
                                date: "15",
                                selected: false,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // TODAY'S CLASSES
                        // ==================================================

                        sectionTitle("Today's Classes"),

                        const SizedBox(height: 18),

                        scheduleTile(
                          time: "10:00 AM",
                          endTime: "11:30 AM",
                          title: "Flutter Development",
                          teacher: "Mr. Ahmed",
                          room: "Room A-203",
                          icon: Icons.phone_android,
                          color: const Color(0xff2563EB),
                        ),

                        const SizedBox(height: 15),

                        scheduleTile(
                          time: "12:00 PM",
                          endTime: "01:30 PM",
                          title: "Database Systems",
                          teacher: "Dr. Ali",
                          room: "Lab B-102",
                          icon: Icons.storage,
                          color: const Color(0xff10B981),
                        ),

                        const SizedBox(height: 15),

                        scheduleTile(
                          time: "03:00 PM",
                          endTime: "04:30 PM",
                          title: "Artificial Intelligence",
                          teacher: "Prof. Khan",
                          room: "Room C-301",
                          icon: Icons.psychology,
                          color: const Color(0xff8B5CF6),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // UPCOMING
                        // ==================================================

                        sectionTitle("Upcoming Classes"),

                        const SizedBox(height: 18),

                        upcomingTile(
                          day: "THU",
                          date: "13",
                          title: "UI / UX Design",
                          time: "09:30 AM - 11:00 AM",
                          room: "Room A-105",
                          color: Colors.deepOrange,
                        ),

                        const SizedBox(height: 15),

                        upcomingTile(
                          day: "FRI",
                          date: "14",
                          title: "Web Development",
                          time: "11:00 AM - 12:30 PM",
                          room: "Lab C-201",
                          color: Colors.teal,
                        ),

                        const SizedBox(height: 15),

                        upcomingTile(
                          day: "SAT",
                          date: "15",
                          title: "Software Engineering",
                          time: "10:00 AM - 11:30 AM",
                          room: "Room B-204",
                          color: Colors.indigo,
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // REMINDER
                        // ==================================================

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(.15),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.notifications_active_rounded,
                                  color: Colors.orange,
                                ),
                              ),

                              const SizedBox(width: 15),

                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Class Reminder",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Your Flutter class starts at 10:00 AM",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.title,
      ),
    );
  }

  // ================================================================
  // DAY CARD
  // ================================================================

  Widget dayCard({
    required String day,
    required String date,
    required bool selected,
  }) {
    return Container(
      width: 68,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: selected ? Colors.white70 : Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            date,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.title,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SCHEDULE TILE
  // ================================================================

  Widget scheduleTile({
    required String time,
    required String endTime,
    required String title,
    required String teacher,
    required String room,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time
          SizedBox(
            width: 78,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  endTime,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 58,
            width: 2,
            color: color.withOpacity(.25),
          ),

          const SizedBox(width: 14),

          // Icon
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  teacher,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  room,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // UPCOMING TILE
  // ================================================================

  Widget upcomingTile({
    required String day,
    required String date,
    required String title,
    required String time,
    required String room,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date
          Container(
            height: 64,
            width: 62,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  room,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: color,
          ),
        ],
      ),
    );
  }
}