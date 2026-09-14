import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController();

  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>();

  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND RESET EMAIL
  // ============================================================

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password reset link has been sent to your email.",
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'user-not-found':
          message = "No account found with this email.";
          break;

        case 'invalid-email':
          message = "Please enter a valid email address.";
          break;

        case 'too-many-requests':
          message =
          "Too many requests. Please try again later.";
          break;

        default:
          message =
          "Something went wrong. Please try again.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to send reset email. Please try again.",
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.title,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),

          child: Form(
            key: formKey,

            child: Column(
              children: [
                const SizedBox(height: 35),

                // ==================================================
                // ICON
                // ==================================================

                Container(
                  height: 100,
                  width: 100,

                  decoration: BoxDecoration(
                    color: const Color(0xffEAF1FF),
                    borderRadius:
                    BorderRadius.circular(30),
                  ),

                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 55,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // TITLE
                // ==================================================

                const Text(
                  "Forgot Password?",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Don't worry! Enter your email address "
                      "and we'll send you a link to reset "
                      "your password.",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),

                // ==================================================
                // EMAIL LABEL
                // ==================================================

                const Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.title,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ==================================================
                // EMAIL FIELD
                // ==================================================

                TextFormField(
                  controller: emailController,

                  keyboardType:
                  TextInputType.emailAddress,

                  textInputAction:
                  TextInputAction.done,

                  decoration: InputDecoration(
                    hintText: "Enter your email",

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),

                    contentPadding:
                    const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                  ),

                  validator: (value) {
                    final email =
                        value?.trim() ?? '';

                    if (email.isEmpty) {
                      return "Please enter your email";
                    }

                    final emailRegex = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );

                    if (!emailRegex.hasMatch(email)) {
                      return "Please enter a valid email";
                    }

                    return null;
                  },

                  onFieldSubmitted: (_) {
                    if (!isLoading) {
                      sendResetLink();
                    }
                  },
                ),

                const SizedBox(height: 25),

                // ==================================================
                // SEND BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed:
                    isLoading ? null : sendResetLink,

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.primary,

                      disabledBackgroundColor:
                      AppColors.primary
                          .withOpacity(.6),

                      elevation: 6,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(17),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,

                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "SEND RESET LINK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // BACK TO LOGIN
                // ==================================================

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}