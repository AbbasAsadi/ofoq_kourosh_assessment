import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:ofoq_kourosh_assessment/gen/assets.gen.dart';
import 'package:ofoq_kourosh_assessment/src/components/app_text_field.dart';
import 'package:ofoq_kourosh_assessment/src/components/submit_button.dart';
import 'package:ofoq_kourosh_assessment/src/helper/app_validator.dart';
import 'package:ofoq_kourosh_assessment/src/helper/context_extensions.dart';
import 'package:ofoq_kourosh_assessment/src/helper/error_handler.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_bloc/auth_bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_bloc/auth_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_bloc/auth_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_routes/home_routes.dart';
import 'package:ofoq_kourosh_assessment/src/theme/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const _AuthPage(),
    );
  }
}

class _AuthPage extends StatefulWidget {
  const _AuthPage();

  @override
  State<_AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<_AuthPage> with ErrorHandler {
  final GlobalKey<FormState> formKey = GlobalKey();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isRegisterUI = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (isRegisterUI) {
            showSuccessMessage(context, 'کاربر با موفقیت ساخته شد');
            confirmPasswordController.clear();
            setState(() {
              isRegisterUI = false;
            });
          } else {
            showSuccessMessage(context, 'خوش آمدید');
            HomeRoutes.toHomePage(context);
          }
        } else if (state is AuthFailure) {
          showError(context: context, message: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isRegisterUI ? 'ثبت نام' : 'ورود',
            style: context.textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: context.height * .9,
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,

                  child: Column(
                    children: [
                      Gap(80),
                      Text('خوش آمدید', style: context.textTheme.titleLarge),
                      Gap(32),
                      Image.asset(Assets.images.logo.path),
                      Spacer(),
                      AppTextField(
                        controller: usernameController,
                        hintText: 'نام کاربری',
                        prefixIcon: SvgPicture.asset(Assets.icons.profile),
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.usernameValidator,
                      ),
                      Gap(24),
                      AppTextField(
                        controller: passwordController,
                        hintText: 'رمزعبور',
                        keyboardType: TextInputType.text,
                        prefixIcon: SvgPicture.asset(Assets.icons.lock),
                        maxLines: 1,
                        obscureText: true,
                        textInputAction: isRegisterUI
                            ? TextInputAction.next
                            : null,
                        validator: (value) => isRegisterUI
                            ? AppValidator.registerPasswordValidator(
                                value,
                                confirmPasswordController.text,
                              )
                            : AppValidator.loginPasswordValidator(value),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                        child: isRegisterUI
                            ? Column(
                                children: [
                                  Gap(24),
                                  AppTextField(
                                    controller: confirmPasswordController,
                                    hintText: 'تکرار رمزعبور',
                                    keyboardType: TextInputType.text,
                                    prefixIcon: SvgPicture.asset(
                                      Assets.icons.lock,
                                    ),
                                    maxLines: 1,
                                    obscureText: true,
                                    validator: (value) =>
                                        AppValidator.registerPasswordValidator(
                                          value,
                                          passwordController.text,
                                        ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ),
                      Gap(24),
                      BlocSelector<AuthBloc, AuthState, bool>(
                        selector: (state) => state is AuthLoading,
                        builder: (context, isLoading) {
                          return SubmitButton(
                            isLoading: isLoading,
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                String username = usernameController.text;
                                String password = passwordController.text;

                                if (isRegisterUI) {
                                  context.read<AuthBloc>().add(
                                    RegisterRequestEvent(
                                      username: username,
                                      password: password,
                                    ),
                                  );
                                } else {
                                  context.read<AuthBloc>().add(
                                    LoginRequestEvent(
                                      username: username,
                                      password: password,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isRegisterUI ? 'ثبت نام' : 'ورود',
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                                Gap(8),
                                SvgPicture.asset(
                                  isRegisterUI
                                      ? Assets.icons.tickSquare
                                      : Assets.icons.login,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Gap(60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isRegisterUI
                                ? 'حساب کاربری دارید؟'
                                : 'حساب کاربری ندارید؟',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: AppColors.textDark,
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              isRegisterUI = !isRegisterUI;
                              usernameController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                            }),
                            child: Text(
                              isRegisterUI ? 'ورود' : 'ثبت نام',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: AppColors.primary,
                              ),
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
    );
  }
}
