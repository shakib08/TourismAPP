import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tuition_media/Admin/Users/screen/userdetails.dart';
import 'package:tuition_media/Home/screen/home.dart';
import 'package:tuition_media/Login/screen/login.dart';
import 'package:tuition_media/Profile/screens/profileScreen.dart';
import 'package:tuition_media/Registration/screen/registration.dart';
import 'Admin/AdminHome/Screens/adminhome.dart';
import 'Admin/Tours/Screen/activeTourlist.dart';
import 'Admin/Users/controller/usercontroller.dart';
import 'Tours/screens/tour_details.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  } catch (e) {
    // Handle Firebase initialization error
    debugPrint('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

// This is where we handle the logic for checking if the user is authenticated.
final GoRouter _router = GoRouter(
  initialLocation: '/auth-check', // Default initial route
  routes: <RouteBase>[
    GoRoute(
      path: '/auth-check',
      builder: (context, state) =>
          const AuthCheck(), // Check user authentication state
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const Registration(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => UserProfileScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => AdminHomePage(),
    ),
    GoRoute(
      path: '/admin_tour',
      builder: (context, state) => AdminToursScreen(),
    ),
    GoRoute(
      path: '/tour_details',
      builder: (context, state) {
        // Ensure that the 'extra' is passed correctly as a Map<String, dynamic>
        final tour = state.extra as Map<String, dynamic>;
        return TourDetailsScreen(tour: tour);
      },
    ),

  ],
);

/// Widget that checks if the user is logged in or not and navigates accordingly


class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the user is authenticated
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If the user is logged in, check for admin email
      if (user.email == 'admin@gmail.com') {
        Future.microtask(() => context.go('/admin')); // Redirect to Admin page
      } else {
        Future.microtask(() => context.go('/home')); // Redirect to HomeScreen
      }
    } else {
      // If the user is not logged in, redirect to LoginScreen
      Future.microtask(() => context.go('/login'));
    }

    // While deciding, show a loading indicator
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

