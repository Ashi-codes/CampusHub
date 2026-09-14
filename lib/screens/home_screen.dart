import 'package:flutter/material.dart';

import 'quiz_start_screen.dart';
import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomIndex = 0;

  final TextEditingController _searchController =
  TextEditingController();

  String searchQuery = '';


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;
    final bool isDesktop = size.width >= 1000;

    final double maxContentWidth = isDesktop
        ? 1100
        : isTablet
        ? 900
        : double.infinity;

    final double horizontalPadding = isDesktop
        ? 30
        : isTablet
        ? 28
        : 22;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      // ============================================================
      // BODY
      // ============================================================

      body: Stack(
        children: [
          const BackgroundEffect(),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    18,
                    horizontalPadding,
                    30,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // HEADER
                        // ==================================================

                        Row(
                          children: [
                            Container(
                              height: isTablet ? 62 : 58,
                              width: isTablet ? 62 : 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.school_rounded,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Good Morning 👋",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: isTablet ? 16 : 15,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "Ayesha",
                                    style: TextStyle(
                                      fontSize: isTablet ? 27 : 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.title,
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  Text(
                                    "Welcome back to CampusHub",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: isTablet ? 15 : 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 54,
                              width: 54,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(28),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 42,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 22),

                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.notifications_active_rounded,
                                                  color: AppColors.primary,
                                                  size: 26,
                                                ),

                                                SizedBox(width: 10),

                                                Text(
                                                  "Notifications",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.title,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 20),

                                            _notificationTile(
                                              icon: Icons.assignment_rounded,
                                              title: "Assignment Reminder",
                                              message: "UI Design Submission is due tomorrow.",
                                              color: Colors.orange,
                                            ),

                                            const SizedBox(height: 12),

                                            _notificationTile(
                                              icon: Icons.book_rounded,
                                              title: "New Course Added",
                                              message: "Artificial Intelligence is now available.",
                                              color: Colors.blue,
                                            ),

                                            const SizedBox(height: 12),

                                            _notificationTile(
                                              icon: Icons.event_available_rounded,
                                              title: "Class Reminder",
                                              message: "Flutter Development starts at 10:00 AM.",
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // SEARCH
                        // ==================================================

                        Container(
                          height: 58,
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
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.trim().toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search courses, tasks...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primary,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // SEARCH RESULTS
                        // ==================================================

                        if (searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 20),

                          sectionTitle("Search Results"),

                          const SizedBox(height: 15),

                          SizedBox(
                            height: 175,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                if ("flutter mr ahmed".contains(searchQuery))
                                  GestureDetector(
                                    onTap: () {
                                      _openCourseDetails(
                                        context,
                                        "Flutter",
                                        "Mr. Ahmed",
                                      );
                                    },
                                    child: courseCard(
                                      title: "Flutter",
                                      teacher: "Mr. Ahmed",
                                      color: Colors.blue,
                                      icon: Icons.phone_android,
                                    ),
                                  ),

                                if ("database dr ali".contains(searchQuery))
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _openCourseDetails(
                                          context,
                                          "Database",
                                          "Dr. Ali",
                                        );
                                      },
                                      child: courseCard(
                                        title: "Database",
                                        teacher: "Dr. Ali",
                                        color: Colors.green,
                                        icon: Icons.storage,
                                      ),
                                    ),
                                  ),

                                if ("ai artificial intelligence prof khan"
                                    .contains(searchQuery))
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _openCourseDetails(
                                          context,
                                          "AI",
                                          "Prof. Khan",
                                        );
                                      },
                                      child: courseCard(
                                        title: "AI",
                                        teacher: "Prof. Khan",
                                        color: Colors.deepPurple,
                                        icon: Icons.psychology,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],

                        // ==================================================
                        // SEMESTER PROGRESS
                        // ==================================================
                if (searchQuery.isEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            isTablet ? 26 : 22,
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
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(.25),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.school_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      "Semester Progress",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isTablet ? 22 : 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              Text(
                                "76% Completed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 30 : 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 15),

                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(20),
                                child: const LinearProgressIndicator(
                                  value: .76,
                                  minHeight: 10,
                                  backgroundColor: Colors.white30,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "4 Courses Remaining",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding:
                                    const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // QUICK STATISTICS
                        // ==================================================

                        sectionTitle("Quick Statistics"),

                        const SizedBox(height: 6),

                        const Text(
                          "Monitor your campus activity",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ==================================================
                        // FIXED STATISTICS GRID
                        // ==================================================

                        LayoutBuilder(
                          builder: (context, constraints) {
                            final bool fourColumns =
                                constraints.maxWidth >= 900;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                fourColumns ? 4 : 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,

                                // IMPORTANT:
                                // Fixed height prevents overflow
                                mainAxisExtent:
                                fourColumns ? 190 : 190,
                              ),
                              itemBuilder: (context, index) {
                                final cards = [
                                  {
                                    "icon":
                                    Icons.menu_book_rounded,
                                    "title": "Courses",
                                    "value": "05",
                                    "color":
                                    const Color(0xff2563EB),
                                  },
                                  {
                                    "icon":
                                    Icons.assignment_rounded,
                                    "title": "Assignments",
                                    "value": "12",
                                    "color":
                                    const Color(0xff10B981),
                                  },
                                  {
                                    "icon":
                                    Icons.check_circle_outline_rounded,
                                    "title": "Attendance",
                                    "value": "92%",
                                    "color":
                                    const Color(0xffF59E0B),
                                  },
                                  {
                                    "icon": Icons.star_rounded,
                                    "title": "CGPA",
                                    "value": "3.72",
                                    "color":
                                    const Color(0xff8B5CF6),
                                  },
                                ];

                                return InkWell(
                                  onTap: () {
                                    _handleDashboardCardTap(
                                      context,
                                      cards[index]["title"] as String,
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(22),
                                  child: dashboardCard(
                                    icon: cards[index]["icon"] as IconData,
                                    title: cards[index]["title"] as String,
                                    value: cards[index]["value"] as String,
                                    color: cards[index]["color"] as Color,
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // QUIZ CARD
                        // ==================================================

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            isTablet ? 26 : 22,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7C3AED),
                                Color(0xffA855F7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.purple.withOpacity(.25),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.quiz_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Test Your Knowledge",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 5),

                                        Text(
                                          "Take a quick Flutter quiz",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "10 Questions • 15 Seconds Each",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 18),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const QuizStartScreen(),
                                      ),
                                    );
                                  },
                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.white,
                                    elevation: 0,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Start Quiz",
                                        style: TextStyle(
                                          color:
                                          Color(0xff7C3AED),
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(width: 8),

                                      Icon(
                                        Icons
                                            .arrow_forward_rounded,
                                        color:
                                        Color(0xff7C3AED),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // TODAY'S SCHEDULE
                        // ==================================================

                        sectionTitle("Today's Schedule"),

                        const SizedBox(height: 15),


                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _showScheduleDetails(context);
                      },
                      borderRadius: BorderRadius.circular(22),
                      child:

                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/images/flutter.png",
                                  width: isTablet ? 80 : 70,
                                  height: isTablet ? 80 : 70,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 16),

                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Flutter Development",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 7),

                                    Text(
                                      "10:00 AM - 11:30 AM",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    SizedBox(height: 8),

                                    Text(
                                      "Room A-203",
                                      style: TextStyle(
                                        color:
                                        AppColors.primary,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.primary,
                                size: 17,
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // UPCOMING ASSIGNMENTS
                        // ==================================================

                        sectionTitle("Upcoming Assignments"),

                        const SizedBox(height: 15),

                        assignmentTile(
                          title: "UI Design Submission",
                          subject: "Mobile App Development",
                          due: "Tomorrow",
                          color: Colors.orange,
                        ),

                        const SizedBox(height: 14),

                        assignmentTile(
                          title: "Database Project",
                          subject: "Database Systems",
                          due: "3 Days Left",
                          color: Colors.green,
                        ),

                        const SizedBox(height: 14),

                        assignmentTile(
                          title: "Operating System Quiz",
                          subject: "Operating Systems",
                          due: "Friday",
                          color: Colors.red,
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // RECENT ACTIVITY
                        // ==================================================

                        sectionTitle("Recent Activity"),

                        const SizedBox(height: 15),

                        activityTile(
                          icon: Icons.check_circle,
                          color: Colors.green,
                          title: "Assignment Submitted",
                          subtitle: "Flutter Development",
                        ),

                        const SizedBox(height: 12),

                        activityTile(
                          icon: Icons.book,
                          color: Colors.blue,
                          title: "New Course Added",
                          subtitle: "Artificial Intelligence",
                        ),

                        const SizedBox(height: 12),

                        activityTile(
                          icon: Icons.notifications_active,
                          color: Colors.orange,
                          title: "Exam Reminder",
                          subtitle: "Operating Systems",
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // MY COURSES
                        // ==================================================


                        sectionTitle("My Courses"),

                        const SizedBox(height: 18),

                        SizedBox(
                          height: 175,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [

                              // FLUTTER
                              if (searchQuery.isEmpty ||
                                  "flutter mr ahmed".contains(searchQuery))
                                GestureDetector(
                                  onTap: () {
                                    _openCourseDetails(
                                      context,
                                      "Flutter",
                                      "Mr. Ahmed",
                                    );
                                  },
                                  child: courseCard(
                                    title: "Flutter",
                                    teacher: "Mr. Ahmed",
                                    color: Colors.blue,
                                    icon: Icons.phone_android,
                                  ),
                                ),

                              // DATABASE
                              if (searchQuery.isEmpty ||
                                  "database dr ali".contains(searchQuery))
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      _openCourseDetails(
                                        context,
                                        "Database",
                                        "Dr. Ali",
                                      );
                                    },
                                    child: courseCard(
                                      title: "Database",
                                      teacher: "Dr. Ali",
                                      color: Colors.green,
                                      icon: Icons.storage,
                                    ),
                                  ),
                                ),

                              // AI
                              if (searchQuery.isEmpty ||
                                  "ai artificial intelligence prof khan"
                                      .contains(searchQuery))
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      _openCourseDetails(
                                        context,
                                        "AI",
                                        "Prof. Khan",
                                      );
                                    },
                                    child: courseCard(
                                      title: "AI",
                                      teacher: "Prof. Khan",
                                      color: Colors.deepPurple,
                                      icon: Icons.psychology,
                                    ),
                                  ),
                                ),

                              // NO RESULT
                              if (searchQuery.isNotEmpty &&
                                  ![
                                    "flutter mr ahmed",
                                    "database dr ali",
                                    "ai artificial intelligence prof khan",
                                  ].any((course) => course.contains(searchQuery)))
                                const SizedBox(
                                  width: 300,
                                  child: Center(
                                    child: Text(
                                      "No course found",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

          const SizedBox(height: 25),

        ], // My Courses if

        ], // 🔴 YE MISSING THA — outer if

      ), // Column

    ), // SingleChildScrollView
    ), // Padding
    ), // ConstrainedBox
    ), // Center
    ), // SafeArea
    ], // Stack children
    ), // Stack
    ); // Scaffold // Scaffold close
  } // build close
  Widget _notificationTile({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _handleDashboardCardTap(
      BuildContext context,
      String title,
      ) {
    late String message;
    late Color color;
    late IconData icon;

    switch (title) {
      case "Courses":
        message = "Your 5 enrolled courses are available.";
        color = const Color(0xff2563EB);
        icon = Icons.menu_book_rounded;
        break;

      case "Assignments":
        message = "You have 12 assignments to manage.";
        color = const Color(0xff10B981);
        icon = Icons.assignment_rounded;
        break;

      case "Attendance":
        message = "Your current attendance is 92%.";
        color = const Color(0xffF59E0B);
        icon = Icons.check_circle_outline_rounded;
        break;

      case "CGPA":
        message = "Your current CGPA is 3.72.";
        color = const Color(0xff8B5CF6);
        icon = Icons.star_rounded;
        break;

      default:
        message = "$title details";
        color = AppColors.primary;
        icon = Icons.info_outline_rounded;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        elevation: 8,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCourseDetails(
      BuildContext context,
      String course,
      String teacher,
      ) {
    Color courseColor;

    IconData courseIcon;

    switch (course) {
      case "Flutter":
        courseColor = const Color(0xff2563EB);
        courseIcon = Icons.phone_android_rounded;
        break;

      case "Database":
        courseColor = const Color(0xff10B981);
        courseIcon = Icons.storage_rounded;
        break;

      default:
        courseColor = const Color(0xff8B5CF6);
        courseIcon = Icons.psychology_rounded;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HANDLE
              Center(
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xffD1D5DB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // COURSE HEADER
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      courseColor,
                      courseColor.withOpacity(.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: courseColor.withOpacity(.22),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Icon(
                        courseIcon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            course,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            teacher,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "70%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PROGRESS
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Course Progress",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.title,
                    ),
                  ),

                  Text(
                    "70% completed",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: courseColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 9),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: .70,
                  minHeight: 7,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(courseColor),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                ),
              ),

              const SizedBox(height: 12),

              // ACTIONS
              Row(
                children: [
                  Expanded(
                    child: _courseAction(
                      icon: Icons.play_circle_fill_rounded,
                      title: "Lessons",
                      subtitle: "Continue learning",
                      color: courseColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _courseAction(
                      icon: Icons.assignment_rounded,
                      title: "Tasks",
                      subtitle: "View assignments",
                      color: courseColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _courseAction(
                      icon: Icons.bar_chart_rounded,
                      title: "Progress",
                      subtitle: "Track performance",
                      color: courseColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _courseAction(
                      icon: Icons.info_outline_rounded,
                      title: "Details",
                      subtitle: "Course information",
                      color: courseColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _courseAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$title selected"),
              backgroundColor: color,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withOpacity(.12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(height: 11),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScheduleDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xffD1D5DB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.10),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.primary,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Schedule",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppColors.title,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your upcoming class",
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

              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.phone_android_rounded,
                        color: AppColors.primary,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flutter Development",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "10:00 AM - 11:30 AM",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Room A-203",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                  ),
                  label: const Text(
                    "Got it",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  // ============================================================
  // SECTION TITLE
  // ============================================================

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

  // ============================================================
  // DASHBOARD CARD
  // ============================================================

  Widget dashboardCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(.15),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),

              Icon(
                Icons.more_horiz,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // VALUE
          Text(
            value,
            style: const TextStyle(
              fontSize: 27,
              height: 1.1,
              fontWeight: FontWeight.bold,
              color: Color(0xff18181B),
            ),
          ),

          const SizedBox(height: 5),

          // TITLE
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              height: 1.1,
              fontWeight: FontWeight.w700,
              color: Color(0xff18181B),
            ),
          ),

          const Spacer(),

          // UPDATED
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.trending_up,
                  color: color,
                  size: 13,
                ),

                const SizedBox(width: 3),

                Text(
                  "Updated",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ASSIGNMENT TILE
  // ============================================================

  Widget assignmentTile({
    required String title,
    required String subject,
    required String due,
    required Color color,
  }) {
    return Container(
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
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.assignment,
              color: color,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Text(
              due,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIVITY TILE
  // ============================================================

  Widget activityTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          CircleAvatar(
            radius: 24,
            backgroundColor:
            color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COURSE CARD
  // ============================================================

  Widget courseCard({
    required String title,
    required String teacher,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white24,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            teacher,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: .70,
              minHeight: 6,
              color: Colors.white,
              backgroundColor: Colors.white24,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV ITEM
  // ============================================================

  Widget _bottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected =
        selectedBottomIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedBottomIndex = index;
          });

          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$label screen coming soon",
                ),
                duration:
                const Duration(milliseconds: 900),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected
                  ? AppColors.primary
                  : Colors.grey.shade400,
            ),

            const SizedBox(height: 5),

            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}