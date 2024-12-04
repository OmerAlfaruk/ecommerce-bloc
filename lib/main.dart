import 'package:ecommers/core/config/theme/app_theme.dart';
import 'package:ecommers/firebase_options.dart';
import 'package:ecommers/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommers/presentation/splash/pages/splash.dart';
import 'package:ecommers/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>SplashCubit()..appStarted())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.appTheme,
        home: const SplashPage(),
      ),
    );
  }
}
