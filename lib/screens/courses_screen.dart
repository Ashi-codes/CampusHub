import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';
import 'course_detail_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    "All",
    "Flutter",
    "UI/UX",
    "AI",
    "Database",
    "Web",
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                          "Explore Courses",
                          style: TextStyle(
                            fontSize: isTablet ? 32 : 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.title,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Find your favourite course",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: isTablet ? 17 : 16,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ==================================================
                        // SEARCH BAR
                        // ==================================================

                        Container(
                          height: 58,
                          width: double.infinity,
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
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Search courses...",
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
                        // CATEGORIES
                        // ==================================================

                        sectionTitle("Categories"),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 46,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = index;
                                  });
                                },
                                child: categoryChip(
                                  categories[index],
                                  selectedCategory == index,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // CONTINUE LEARNING
                        // ==================================================

                        sectionTitle("Continue Learning"),

                        const SizedBox(height: 18),

                        continueCourseCard(
                          title: "Flutter Development",
                          progress: "72%",
                          lessons: "18 / 25 Lessons",
                          color: const Color(0xff2563EB),
                          icon: Icons.phone_android,
                        ),

                        const SizedBox(height: 18),

                        continueCourseCard(
                          title: "Artificial Intelligence",
                          progress: "45%",
                          lessons: "09 / 20 Lessons",
                          color: const Color(0xff8B5CF6),
                          icon: Icons.psychology,
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // POPULAR COURSES
                        // ==================================================

                        sectionTitle("Popular Courses"),

                        const SizedBox(height: 18),

                        // Flutter
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const CourseDetailScreen(
                                  title: "Flutter Masterclass",
                                  image: "assets/images/flutter.png",
                                ),
                              ),
                            );
                          },
                          child: courseCard(
                            title: "Flutter Masterclass",
                            lessons: "28 Lessons",
                            rating: "4.9",
                            icon: Icons.phone_android,
                            color: const Color(0xff2563EB),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // UI/UX
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const CourseDetailScreen(
                                  title: "UI / UX Design",
                                  image: "assets/images/ux.jpg",
                                ),
                              ),
                            );
                          },
                          child: courseCard(
                            title: "UI / UX Design",
                            lessons: "20 Lessons",
                            rating: "4.8",
                            icon: Icons.design_services,
                            color: Colors.deepOrange,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Database
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const CourseDetailScreen(
                                  title: "Database Systems",
                                  image: "assets/images/data.png",
                                ),
                              ),
                            );
                          },
                          child: courseCard(
                            title: "Database Systems",
                            lessons: "16 Lessons",
                            rating: "4.7",
                            icon: Icons.storage,
                            color: Colors.green,
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
  // CATEGORY CHIP
  // ================================================================

  Widget categoryChip(
      String title,
      bool selected,
      ) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary
            : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected
              ? Colors.white
              : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  // ================================================================
  // CONTINUE COURSE CARD
  // ================================================================

  Widget continueCourseCard({
    required String title,
    required String progress,
    required String lessons,
    required Color color,
    required IconData icon,
  }) {
    final double progressValue =
        double.parse(
          progress.replaceAll("%", ""),
        ) /
            100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 27,
                ),
              ),

              const Spacer(),

              Text(
                progress,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Course Name
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          // Lessons
          Text(
            lessons,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 17),

          // Progress
          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor:
              const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // POPULAR COURSE CARD
  // ================================================================

  Widget courseCard({
    required String title,
    required String lessons,
    required String rating,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          // ==========================================================
          // ICON
          // ==========================================================

          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: color,
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          // ==========================================================
          // COURSE INFO
          // ==========================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  lessons,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      rating,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ==========================================================
          // START BUTTON
          // ==========================================================

          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CourseDetailScreen(
                          title: title,
                          image: title ==
                              "Flutter Masterclass"
                              ? "assets/images/flutter.png"
                              : title ==
                              "UI / UX Design"
                              ? "assets/images/ux.jpg"
                              : "assets/images/data.png",
                        ),
                  ),
                );
              },
              style:
              ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor:
                Colors.white,
                elevation: 0,
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Start",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                  FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}