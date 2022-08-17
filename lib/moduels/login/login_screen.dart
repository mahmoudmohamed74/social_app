// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/layout_screen.dart';
import 'package:social_app/moduels/login/cubit/cubit.dart';
import 'package:social_app/moduels/login/cubit/states.dart';
import 'package:social_app/moduels/register/register_screen.dart';
import 'package:social_app/shared/components/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCuibt(),
      child: BlocConsumer<LoginCuibt, LoginStates>(listener: (context, state) {
        if (state is LoginErorrState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is LoginSuccessState) {
          CacheHelper.saveData(
            key: "uId",
            value: state.uId,
          ).then(
            (value) {
              // ShopCubit.get(context) // to update user’s data at every login
              //   ..getHomeData()
              //   ..getCategories()
              //   ..getFavorites()
              //   ..getUserData();
              // cubit.currentIndex = 0;

              navigateAndFinish(
                context,
                LayoutScreen(),
              );
            },
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                //ايرور لوحه المفاتيح
                child: Form //validation
                    (
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "login now to communicate with friends",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "email address must not be empty";
                          }
                          return null;
                        },
                        lable: "Email Address",
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "password is too short";
                          }
                          return null;
                        },
                        lable: "Password",
                        prefix: Icons.lock,
                        suffix: LoginCuibt.get(context).suffix,
                        isPassword: LoginCuibt.get(context).isPassword,
                        suffixPressed: () {
                          LoginCuibt.get(context).changePasswordVisibility();
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            // LoginCuibt.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LoginCuibt.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: "Login",
                          isUpperCase: true,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: "Register now",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
