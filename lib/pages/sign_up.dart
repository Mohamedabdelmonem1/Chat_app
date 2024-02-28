import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../component/custom_button.dart';
import '../component/custom_text_field.dart';
import '../component/snackBar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, "chatpage", arguments: email);
          showSnackBar(context, "success");
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => SafeArea(
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
                          child: const Text("Sign Up",
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
                            onChanged: (data) {
                              password = data;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "Sign Up",
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
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
                              "have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                " Sign In",
                                style: TextStyle(color: Color(0xffDEF4F0)),
                              ),
                            ),
                          ],
                        )
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
