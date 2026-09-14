import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';

class LessonScreen extends StatelessWidget {

  final String image;

  const LessonScreen({
    super.key,
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

              height: 260,
                width: double.infinity,

                decoration:  BoxDecoration(

                  image: DecorationImage(

                    image: AssetImage(
                      image,
                    ),

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

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),

                  ),

                ),

              ),

              const Positioned(

                bottom: 20,
                right: 20,

                child: CircleAvatar(

                  radius: 32,

                  backgroundColor: AppColors.primary,

                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
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
                  /// LESSON TITLE
                  ///==========================

                  const Text(
                  "Lesson 1",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

              const SizedBox(height: 8),

              const Text(
                "Introduction to Flutter",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                ),
              ),

              const SizedBox(height: 25),

              ///==========================
              /// LESSON INFO
              ///==========================

              Row(
                children: [

                  infoCard(
                    Icons.access_time,
                    "12 Min",
                  ),

                  const SizedBox(width: 12),

                  infoCard(
                    Icons.bar_chart,
                    "Beginner",
                  ),

                  const SizedBox(width: 12),

                  infoCard(
                    Icons.play_circle_fill,
                    "Video",
                  ),

                ],
              ),

              const SizedBox(height: 30),

              ///==========================
              /// DESCRIPTION
              ///==========================

              const Text(
                "Lesson Overview",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "In this lesson you'll learn what Flutter is, why it is used for cross-platform development, and how developers build beautiful mobile applications using widgets.",

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Topics Covered",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              topicTile("✔ What is Flutter?"),
              topicTile("✔ Dart Language Basics"),
              topicTile("✔ Widgets"),
              topicTile("✔ Hot Reload"),
              topicTile("✔ Project Structure"),

              const SizedBox(height: 35),
                      ///==========================
                      /// ACTION BUTTONS
                      ///==========================

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download, color: Colors.white),
                          label: const Text(
                            "Download Notes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Lesson Completed ✅"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                          ),
                          label: const Text(
                            "Mark as Complete",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 17,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.primary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Next Lesson",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
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
  /// INFO CARD
  ///==========================

  Widget infoCard(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///==========================
  /// TOPIC TILE
  ///==========================

  Widget topicTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}