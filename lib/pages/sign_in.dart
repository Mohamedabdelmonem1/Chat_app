import 'package:chat_app/component/custom_button.dart';
import 'package:chat_app/component/custom_text_field.dart';
import 'package:chat_app/component/snackBar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, "chatpage", arguments: email);
          BlocProvider.of<ChatCubit>(context).getMessage();
          showSnackBar(context, "success");
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      child: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          kLogo,
                          width: 100,
                        ),
                        const Text(
                          "Scholar Chat",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Pacifico",
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text("Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            hint: "Email",
                            onChanged: (data) {
                              email = data;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hint: "Password",
                            scure: true,
                            onChanged: (data) {
                              password = data;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "Sign In",
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginUser(
                                    email: email!, password: password!);
                              } else {}
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "signUp");
                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) => const SignUp(),));
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(color: Color(0xffDEF4F0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
