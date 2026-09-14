
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/app_textstyles.dart';
import '../utils/app_colors.dart';
import '../widgets/background_effect.dart';
import '../widgets/curved_container.dart';
import '../widgets/dotted_pattern.dart';
import 'main_navigation.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool hidePassword = true;
bool rememberMe = false;
bool isLoading = false;

final emailController = TextEditingController();
final passwordController = TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;

// =========================
// MESSAGE
// =========================

void _showMessage(
String message, {
bool success = false,
}) {
if (!mounted) return;

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
// EMAIL / PASSWORD LOGIN
// =========================

Future<void> _loginUser() async {
FocusScope.of(context).unfocus();

final email = emailController.text.trim();
final password = passwordController.text.trim();

if (email.isEmpty || password.isEmpty) {
_showMessage("Please fill all fields");
return;
}

if (!RegExp(
r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
).hasMatch(email)) {
_showMessage("Enter a valid email");
return;
}

setState(() {
isLoading = true;
});

try {
await _auth.signInWithEmailAndPassword(
email: email,
password: password,
);

if (!mounted) return;

setState(() {
isLoading = false;
});

_showMessage(
"Login Successful",
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
case 'user-not-found':
message = "No account found with this email.";
break;

case 'wrong-password':
case 'invalid-credential':
message = "Invalid email or password.";
break;

case 'invalid-email':
message = "Please enter a valid email address.";
break;

case 'user-disabled':
message = "This account has been disabled.";
break;

case 'too-many-requests':
message = "Too many attempts. Please try again later.";
break;

case 'network-request-failed':
message =
"Network error. Please check your internet connection.";
break;

case 'operation-not-allowed':
message =
"Email/Password authentication is not enabled in Firebase.";
break;

default:
message =
e.message ?? "Login failed. Please try again.";
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
// GOOGLE SIGN-IN
// =========================

Future<void> _googleSignIn() async {
FocusScope.of(context).unfocus();

setState(() {
isLoading = true;
});

try {
final GoogleSignIn googleSignIn = GoogleSignIn.instance;

await googleSignIn.initialize();

final GoogleSignInAccount googleUser =
await googleSignIn.authenticate();

final GoogleSignInAuthentication googleAuth =
googleUser.authentication;

final credential = GoogleAuthProvider.credential(
idToken: googleAuth.idToken,
);

await _auth.signInWithCredential(credential);

if (!mounted) return;

setState(() {
isLoading = false;
});

_showMessage(
"Google Login Successful",
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
} on GoogleSignInException catch (e) {
if (!mounted) return;

setState(() {
isLoading = false;
});

if (e.code == GoogleSignInExceptionCode.canceled) {
_showMessage("Google Sign-In cancelled");
} else {
_showMessage(
"Google Sign-In failed. Please try again.",
);
}
} on FirebaseAuthException catch (e) {
if (!mounted) return;

setState(() {
isLoading = false;
});

_showMessage(
e.message ?? "Google authentication failed.",
);
} catch (e) {
if (!mounted) return;

setState(() {
isLoading = false;
});

_showMessage(
"Google Sign-In failed. Please try again.",
);
}
}

// =========================
// DISPOSE
// =========================

@override
void dispose() {
emailController.dispose();
passwordController.dispose();
super.dispose();
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
? size.height * 0.50
    : isSmallHeight
? size.height * 0.40
    : size.height * 0.46;

final double containerTop = isWideScreen
? size.height * 0.32
    : isSmallHeight
? size.height * 0.27
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
"assets/images/sign.jpg",
fit: BoxFit.cover,
),
),

// =========================
// BACK BUTTON
// =========================

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

// =========================
// LEFT DOTS
// =========================

Positioned(
left: 18,
top: isSmallHeight ? 210 : 300,
child: const DottedPattern(),
),

// =========================
// RIGHT DOTS
// =========================

Positioned(
right: 18,
bottom: 70,
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
isSmallHeight ? 12 : 20,
horizontalPadding,
60,
),

child: ConstrainedBox(
constraints: BoxConstraints(
maxWidth:
isWideScreen ? 850 : double.infinity,
),

child: Column(
children: [

SizedBox(
height:
isSmallHeight ? 18 : 30,
),

// =========================
// WELCOME
// =========================

Text(
"Welcome",
style: AppTextStyles.welcome,
),

Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
Text(
"Back!",
style:
AppTextStyles.welcome.copyWith(
color: AppColors.primary,
),
),

const SizedBox(width: 8),

const Text(
"👋",
style:
TextStyle(fontSize: 30),
),
],
),

const SizedBox(height: 12),

// =========================
// DESCRIPTION
// =========================

Text(
"Sign in to continue your",
textAlign: TextAlign.center,
style: AppTextStyles.body,
),

RichText(
textAlign: TextAlign.center,
text: TextSpan(
children: [
TextSpan(
text: "CampusHub",
style:
AppTextStyles.body.copyWith(
color: AppColors.primary,
fontWeight: FontWeight.bold,
),
),
TextSpan(
text: " journey.",
style: AppTextStyles.body,
),
],
),
),

SizedBox(
height:
isSmallHeight ? 25 : 35,
),

// =========================
// EMAIL LABEL
// =========================

Align(
alignment: Alignment.centerLeft,
child: Text(
"Email Address",
style:
AppTextStyles.body.copyWith(
fontWeight: FontWeight.bold,
color: AppColors.title,
fontSize:
size.width < 360
? 16
    : 18,
),
),
),

const SizedBox(height: 12),

// =========================
// EMAIL FIELD
// =========================

TextField(
inputFormatters: [
FilteringTextInputFormatter.deny(
RegExp(r'\s'),
),
],
controller: emailController,
keyboardType:
TextInputType.emailAddress,
textInputAction:
TextInputAction.next,

decoration: InputDecoration(
hintText: "Enter your email",
filled: true,
fillColor: Colors.white,

focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide:
const BorderSide(
color: AppColors.primary,
width: 2,
),
),

prefixIcon: Container(
margin:
const EdgeInsets.all(10),
decoration: BoxDecoration(
color:
const Color(0xffEEF4FF),
borderRadius:
BorderRadius.circular(12),
),
child: const Icon(
Icons.email_outlined,
color: AppColors.primary,
),
),

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide:
BorderSide.none,
),

enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide: BorderSide(
color: AppColors.border,
),
),
),
),

const SizedBox(height: 25),

// =========================
// PASSWORD LABEL
// =========================

Align(
alignment: Alignment.centerLeft,
child: Text(
"Password",
style:
AppTextStyles.body.copyWith(
fontWeight: FontWeight.bold,
color: AppColors.title,
fontSize:
size.width < 360
? 16
    : 18,
),
),
),

const SizedBox(height: 12),

// =========================
// PASSWORD FIELD
// =========================

TextField(
inputFormatters: [
FilteringTextInputFormatter.deny(
RegExp(r'\s'),
),
],
controller: passwordController,
obscureText: hidePassword,
enableSuggestions: false,
autocorrect: false,
textInputAction:
TextInputAction.done,

decoration: InputDecoration(
hintText:
"Enter your password",
filled: true,
fillColor: Colors.white,

focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide:
const BorderSide(
color: AppColors.primary,
width: 2,
),
),

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide:
BorderSide.none,
),

prefixIcon: Container(
margin:
const EdgeInsets.all(10),
decoration: BoxDecoration(
color:
const Color(0xffEEF4FF),
borderRadius:
BorderRadius.circular(12),
),
child: const Icon(
Icons.lock_outline,
color: AppColors.primary,
),
),

suffixIcon: IconButton(
onPressed: () {
setState(() {
hidePassword =
!hidePassword;
});
},
icon: Icon(
hidePassword
? Icons
    .visibility_off_outlined
    : Icons
    .visibility_outlined,
color: Colors.grey,
),
),

enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(18),
borderSide: BorderSide(
color: AppColors.border,
),
),
),
),

const SizedBox(height: 15),

// =========================
// REMEMBER / FORGOT
// =========================

Wrap(
alignment:
WrapAlignment.spaceBetween,
crossAxisAlignment:
WrapCrossAlignment.center,
spacing: 5,
runSpacing: 0,
children: [

Row(
mainAxisSize:
MainAxisSize.min,
children: [
Checkbox(
value: rememberMe,
activeColor:
AppColors.primary,
onChanged: (value) {
setState(() {
rememberMe =
value ?? false;
});
},
),

Text(
"Remember Me",
style: AppTextStyles.body
    .copyWith(
fontSize:
size.width < 360
? 14
    : 16,
),
),
],
),

TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
const ForgotPasswordScreen(),
),
);
},
child: Text(
"Forgot Password?",
style: TextStyle(
color:
AppColors.primary,
fontWeight:
FontWeight.bold,
fontSize:
size.width < 360
? 13
    : 14,
),
),
),
],
),

const SizedBox(height: 20),

// =========================
// LOGIN BUTTON
// =========================

SizedBox(
width: double.infinity,
height: 58,
child: ElevatedButton(
onPressed:
isLoading ? null : _loginUser,

style:
ElevatedButton.styleFrom(
backgroundColor:
AppColors.primary,
elevation: 8,
shadowColor:
AppColors.shadow,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(18),
),
),

child: isLoading
? const SizedBox(
height: 26,
width: 26,
child:
CircularProgressIndicator(
strokeWidth: 3,
color: Colors.white,
),
)
    : Row(
children: const [
SizedBox(width: 18),

Expanded(
child: Center(
child: Text(
"LOGIN",
style:
TextStyle(
color:
Colors.white,
fontWeight:
FontWeight.bold,
fontSize: 20,
),
),
),
),

Icon(
Icons.arrow_forward,
color:
Colors.white,
size: 28,
),
],
),
),
),

const SizedBox(height: 35),

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
padding:
const EdgeInsets.symmetric(
horizontal: 12,
),
child: Text(
"OR CONTINUE WITH",
textAlign:
TextAlign.center,
style: TextStyle(
color: Colors.grey,
fontWeight:
FontWeight.w600,
fontSize:
size.width < 360
? 11
    : 13,
),
),
),
),

const Expanded(
child: Divider(),
),
],
),

const SizedBox(height: 28),

// =========================
// GOOGLE + FACEBOOK
// =========================

Row(
children: [

// GOOGLE
Expanded(
child: InkWell(
borderRadius:
BorderRadius.circular(18),
onTap: isLoading
? null
    : _googleSignIn,

child: Container(
height: 60,
decoration:
BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(
18),
boxShadow: const [
BoxShadow(
color:
Colors.black12,
blurRadius: 12,
offset:
Offset(0, 4),
),
],
),

child: Row(
mainAxisAlignment:
MainAxisAlignment
    .center,
children: const [
Icon(
Icons.g_mobiledata,
color: Colors.red,
size: 42,
),

SizedBox(width: 6),

Flexible(
child: Text(
"Google",
overflow:
TextOverflow
    .ellipsis,
style: TextStyle(
fontWeight:
FontWeight.w600,
),
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
child: InkWell(
borderRadius:
BorderRadius.circular(18),
onTap: () {
_showMessage(
"Facebook Sign-In is not configured yet.",
);
},

child: Container(
height: 60,
decoration:
BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(
18),
boxShadow: const [
BoxShadow(
color:
Colors.black12,
blurRadius: 12,
offset:
Offset(0, 4),
),
],
),

child: Row(
mainAxisAlignment:
MainAxisAlignment
    .center,
children: const [
Icon(
Icons.facebook,
color:
Color(0xff1877F2),
size: 30,
),

SizedBox(width: 6),

Flexible(
child: Text(
"Facebook",
overflow:
TextOverflow
    .ellipsis,
style: TextStyle(
fontWeight:
FontWeight.w600,
fontSize: 15,
),
),
),
],
),
),
),
),
],
),

const SizedBox(height: 40),

// =========================
// SIGN UP
// =========================

Wrap(
alignment:
WrapAlignment.center,
children: [
Text(
"Don't have an account? ",
style:
AppTextStyles.body,
),

GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const RegisterScreen(),
),
);
},
child: const Text(
"Sign Up",
style: TextStyle(
color:
AppColors.primary,
fontWeight:
FontWeight.bold,
fontSize: 17,
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
