import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';
import 'lesson_screen.dart';
class CourseDetailScreen extends StatelessWidget {

  final String title;
  final String image;

  const CourseDetailScreen({
    super.key,
    required this.title,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF7F9FC),

        body: Stack(
            children: [

            const BackgroundEffect(),

        SafeArea(
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

              ///==========================
              /// TOP IMAGE
              ///==========================

              Stack(
              children: [

              Container(
              height: 280,
                width: double.infinity,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 18,
                left: 18,

                child: CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(

                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Positioned(
                top: 18,
                right: 18,

                child: CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              ],
            ),

            const SizedBox(height: 25),

            Padding(

                padding: const EdgeInsets.symmetric(horizontal: 22),

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                  ///==========================
                  /// COURSE TITLE
                  ///==========================

                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.title,
                        ),
                      ),

              const SizedBox(height: 18),

              ///==========================
              /// COURSE INFO
              ///==========================

              Row(
                children: [

                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),

                  const SizedBox(width: 5),

                  const Text(
                    "4.9",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Icon(
                    Icons.people,
                    color: AppColors.primary,
                  ),

                  const SizedBox(width: 5),

                  const Text(
                    "12k Students",
                  ),

                  const SizedBox(width: 18),

                  const Icon(
                    Icons.access_time,
                    color: AppColors.primary,
                  ),

                  const SizedBox(width: 5),

                  const Text(
                    "28 Hours",
                  ),

                ],
              ),

              const SizedBox(height: 28),

              ///==========================
              /// DESCRIPTION
              ///==========================

              const Text(
                "About Course",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Learn Flutter from beginner to advanced level. "
                    "This course covers Widgets, UI Design, Navigation, "
                    "Firebase, API Integration, State Management and "
                    "everything required to build modern Android and iOS applications.",

                style: TextStyle(
                  color: Colors.grey,
                  height: 1.7,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              ///==========================
              /// LESSONS
              ///==========================

              const Text(
                "Course Lessons",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

                      lessonTile(
                        context,
                        "Introduction",
                        Icons.play_circle_fill,
                      ),

                      lessonTile(
                        context,
                        "Flutter Widgets",
                        Icons.play_circle_fill,
                      ),

                      lessonTile(
                        context,
                        "Navigation",
                        Icons.play_circle_fill,
                      ),

                      lessonTile(
                        context,
                        "State Management",
                        Icons.play_circle_fill,
                      ),

                      lessonTile(
                        context,
                        "Firebase",
                        Icons.play_circle_fill,
                      ),

                      lessonTile(
                        context,
                        "REST API",
                        Icons.play_circle_fill,
                      ),


              const SizedBox(height: 35),

                      ///==========================
                      /// START BUTTON
                      ///==========================

                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(

                          onPressed: () {

                            ScaffoldMessenger.of(context).showSnackBar(

                              const SnackBar(
                                content: Text("Course Started 🚀"),
                              ),

                            );

                          },

                          style: ElevatedButton.styleFrom(

                            backgroundColor: AppColors.primary,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),

                          ),

                          child: const Text(

                            "Start Learning",

                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),

                          ),

                        ),
                      ),

                      const SizedBox(height: 30),

                    ],
                ),
            ),
                ],
              ),
            ),
        ),
            ],
        ),
    );
  }

  ///==========================
  /// LESSON TILE
  ///==========================

  Widget lessonTile(
      BuildContext context,
      String title,
      IconData icon,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonScreen(
              image: image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(.15),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  }