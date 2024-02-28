import 'dart:io';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/sign_in.dart';
import 'package:chat_app/pages/sign_up.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyAUIXqRPFdzXemZSLQwlmNrX6-e5LpaD9g",
            appId: "1:367855392274:android:ac70e96e277ffeab48aacb",
            messagingSenderId: "367855392274",
            projectId: "chat-app-ddfe5",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          "signUp": (context) => const SignUp(),
          "signIn": (context) => const SignIn(),
          "chatpage": (context) => const ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: "signIn",
        // initialRoute: FirebaseAuth.instance.currentUser==null?"signIn":"chatpage",
      ),
    );
  }
}
