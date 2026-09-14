import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_textstyles.dart';
import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';
import '../widgets/curved_container.dart';
import '../widgets/dotted_pattern.dart';
import 'main_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool agreeTerms = false;
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================
  // MESSAGE
  // =========================

  void _showMessage(
      String message, {
        bool success = false,
      }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success
                  ? Icons.check_circle_outline
                  : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor:
        success ? const Color(0xff16A34A) : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // =========================
  // REGISTER WITH FIREBASE
  // =========================

  Future<void> _registerUser() async {
    FocusScope.of(context).unfocus();

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // -------------------------
    // VALIDATION
    // -------------------------

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      _showMessage("Enter a valid email");
      return;
    }

    if (password.length < 6) {
      _showMessage(
        "Password must be at least 6 characters",
      );
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match");
      return;
    }

    if (!agreeTerms) {
      _showMessage(
        "Please accept Terms & Conditions",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // -------------------------
    // FIREBASE
    // -------------------------

    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        "Account created successfully!",
        success: true,
      );

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message =
          "An account already exists with this email.";
          break;

        case 'invalid-email':
          message =
          "Please enter a valid email address.";
          break;

        case 'weak-password':
          message =
          "Password is too weak. Use at least 6 characters.";
          break;

        case 'network-request-failed':
          message =
          "Network error. Check your internet connection.";
          break;

        case 'operation-not-allowed':
          message =
          "Email/Password authentication is not enabled.";
          break;

        default:
          message =
              e.message ?? "Registration failed. Please try again.";
      }

      _showMessage(message);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        "Something went wrong. Please try again.",
      );
    }
  }

  // =========================
  // SOCIAL LOGIN PLACEHOLDERS
  // =========================

  void _googleSignIn() {
    _showMessage(
      "Google Sign-In is not configured yet.",
    );
  }

  void _facebookSignIn() {
    _showMessage(
      "Facebook Sign-In is not configured yet.",
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isSmallHeight = size.height < 700;
    final bool isWideScreen = size.width > 700;

    final double imageHeight = isWideScreen
        ? size.height * 0.48
        : isSmallHeight
        ? size.height * 0.38
        : size.height * 0.42;

    final double containerTop = isWideScreen
        ? size.height * 0.29
        : isSmallHeight
        ? size.height * 0.25
        : size.height * 0.30;

    final double horizontalPadding = isWideScreen
        ? 70
        : size.width < 360
        ? 18
        : 30;

    return Scaffold(
        backgroundColor: AppColors.background,

        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },

            child: SafeArea(
                child: Stack(
                    children: [
                    const BackgroundEffect(),

                SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Image.asset(
                    "assets/images/reg.jpg",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 20,
                  left: isWideScreen ? 35 : 20,
                  child: Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primary,
                        size: 21,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 18,
                  top: isSmallHeight ? 190 : 300,
                  child: const DottedPattern(),
                ),

                Positioned(
                  right: 18,
                  bottom: 70,
                  child: const DottedPattern(),
                ),

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
                            isSmallHeight ? 15 : 25,
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
                                  height: isSmallHeight ? 15 : 25,
                                ),

                                // =========================
                                // TITLE
                                // =========================

                                Text(
                                  "Create",
                                  style: AppTextStyles.welcome,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Account",
                                        style: AppTextStyles.welcome.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    const Text(
                                      "✨",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // =========================
                                // DESCRIPTION
                                // =========================

                                Text(
                                  "Join CampusHub and start your",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.body,
                                ),

                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "smart campus ",
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      TextSpan(
                                        text: "journey today.",
                                        style: AppTextStyles.body,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: isSmallHeight ? 25 : 35,
                                ),

                                // =========================
                                // FULL NAME
                                // =========================

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Full Name",
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.title,
                                      fontSize: size.width < 360 ? 16 : 18,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                TextField(
                                  controller: nameController,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,

                                  decoration: InputDecoration(
                                    hintText: "Enter your full name",
                                    filled: true,
                                    fillColor: Colors.white,

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 2,
                                      ),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),

                                    prefixIcon: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEF4FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.person_outline,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                // =========================
                                // EMAIL
                                // =========================

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email Address",
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.title,
                                      fontSize: size.width < 360 ? 16 : 18,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,

                                  decoration: InputDecoration(
                                    hintText: "Enter your email",
                                    filled: true,
                                    fillColor: Colors.white,

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 2,
                                      ),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),

                                    prefixIcon: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEF4FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.email_outlined,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                // =========================
                                // PASSWORD
                                // =========================

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Password",
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.title,
                                      fontSize: size.width < 360 ? 16 : 18,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                TextField(
                                  controller: passwordController,
                                  obscureText: hidePassword,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.next,

                                  decoration: InputDecoration(
                                    hintText: "Enter password",
                                    filled: true,
                                    fillColor: Colors.white,

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 2,
                                      ),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),

                                    prefixIcon: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEF4FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.lock_outline,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: Icon(
                                        hidePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                // =========================
                                // CONFIRM PASSWORD
                                // =========================

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Confirm Password",
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.title,
                                      fontSize: size.width < 360 ? 16 : 18,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                TextField(
                                  controller: confirmPasswordController,
                                  obscureText: hideConfirmPassword,

                                  decoration: InputDecoration(
                                    hintText: "Confirm password",
                                    filled: true,
                                    fillColor: Colors.white,

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 2,
                                      ),
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),

                                    prefixIcon: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEF4FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.lock_outline,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hideConfirmPassword =
                                          !hideConfirmPassword;
                                        });
                                      },
                                      icon: Icon(
                                        hideConfirmPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // =========================
                                // TERMS
                                // =========================

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Checkbox(
                                      value: agreeTerms,
                                      activeColor: AppColors.primary,
                                      onChanged: (value) {
                                        setState(() {
                                          agreeTerms = value ?? false;
                                        });
                                      },
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: const Color(0xff667085),
                                              fontSize:
                                              size.width < 360 ? 13 : 14,
                                            ),
                                            children: const [
                                              TextSpan(
                                                text: "I agree to the ",
                                              ),
                                              TextSpan(
                                                text: "Terms & Conditions",
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " and ",
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
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 25),

                                // =========================
                                // REGISTER BUTTON
                                // =========================

                                SizedBox(
                                  width: double.infinity,
                                  height: 58,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : _registerUser,

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      disabledBackgroundColor:
                                      AppColors.primary.withOpacity(0.6),
                                      elevation: 8,
                                      shadowColor: AppColors.shadow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),

                                    child: isLoading
                                        ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                        : Row(
                                      children: [
                                        const Icon(
                                          Icons.person_add_alt_1,
                                          color: Colors.white,
                                        ),

                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "CREATE ACCOUNT",
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                size.width < 360
                                                    ? 16
                                                    : 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // =========================
                                // OR CONTINUE
                                // =========================

                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(),
                                    ),

                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          "OR CONTINUE WITH",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                            size.width < 360 ? 11 : 13,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const Expanded(
                                      child: Divider(),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 25),

                                // =========================
                                // SOCIAL BUTTONS
                                // =========================

                                Row(
                                  children: [

                                    // GOOGLE
                                    Expanded(
                                      child: SizedBox(
                                        height: 58,
                                        child: OutlinedButton(
                                          onPressed: _googleSignIn,
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(
                                              color: AppColors.border,
                                              width: 1.2,
                                            ),
                                            elevation: 2,
                                            shadowColor: Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.g_mobiledata,
                                                color: Colors.red,
                                                size: 38,
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                "Google",
                                                style: TextStyle(
                                                  color: AppColors.title,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // FACEBOOK
                                    Expanded(
                                      child: SizedBox(
                                        height: 58,
                                        child: OutlinedButton(
                                          onPressed: _facebookSignIn,
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(
                                              color: AppColors.border,
                                              width: 1.2,
                                            ),
                                            elevation: 2,
                                            shadowColor: Colors.black12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.facebook,
                                                color: Color(0xff1877F2),
                                                size: 28,
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                "Facebook",
                                                style: TextStyle(
                                                  color: AppColors.title,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 35),

                                // =========================
                                // LOGIN
                                // =========================

                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                    ),
                ),
                    ],
                ),
            ),
        ),
    );
  }
}