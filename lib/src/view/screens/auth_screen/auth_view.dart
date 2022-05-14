import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/colors.gen.dart';
import 'package:blog_club/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:blog_club/src/bloc/auth_bloc/auth_event.dart';
import 'package:blog_club/src/bloc/auth_bloc/auth_state.dart';
import 'package:blog_club/src/configs/app_theme.dart';
import 'package:blog_club/src/core/util/validators.dart';
import 'package:blog_club/src/view/components/button_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthView extends StatefulWidget {
  AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _fullnameController;
  late final FocusNode _usernameFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _fullnameFocus;

  @override
  void initState() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _fullnameController = TextEditingController();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _fullnameFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: _authBody(context, _size),
      ),
    );
  }

  Widget _authBody(BuildContext context, Size _size) {
    return SafeArea(
      child: Column(
        children: [
          _logoWidget(context),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: lightTheme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
              ),
              child:
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 68,
                      child: _authModesButtons(context, state),
                    ),
                    Expanded(
                      child: Container(
                        width: _size.width,
                        decoration: BoxDecoration(
                          color: lightTheme.colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: context.read<AuthBloc>().formKey,
                              child: state.authMode == AuthMode.login
                                  ? _loginWidget(context, state)
                                  : _signupWidget(context, state),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoWidget(BuildContext context) {
    return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: SvgPicture.asset(
            Assets.img.icons.logo.path,
          ),
        );
  }

  Widget _authModesButtons(BuildContext context, AuthState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            context.read<AuthBloc>().add(AuthModeChanged());
            _userNameController.clear();
            _passwordController.clear();
            _fullnameFocus.unfocus();
            context.read<AuthBloc>().formKey.currentState!.reset();
          },
          child: Text(
            'log in'.toUpperCase(),
            style: lightTheme.textTheme.headline5!.apply(
                color: state.authMode == AuthMode.login
                    ? ColorName.white
                    : ColorName.white.withOpacity(0.2)),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<AuthBloc>().add(AuthModeChanged());
            _userNameController.clear();
            _passwordController.clear();
            _fullnameController.clear();
            _usernameFocus.unfocus();
            context.read<AuthBloc>().formKey.currentState!.reset();
          },
          child: Text(
            'sign up'.toUpperCase(),
            style: lightTheme.textTheme.headline5!.apply(
                color: state.authMode == AuthMode.signup
                    ? ColorName.white
                    : ColorName.white.withOpacity(0.2)),
          ),
        )
      ],
    );
  }

  Widget _signupWidget(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Blog Club',
          style: lightTheme.textTheme.headline4,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Enter your information',
          style: lightTheme.textTheme.subtitle1!.apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: nameValidator,
          focusNode: _fullnameFocus,
          autocorrect: true,
          controller: _fullnameController,
          decoration: const InputDecoration(
            label: Text('Fullname'),
          ),
        ),
        _usernameTextField(context),
        const SizedBox(
          height: 8,
        ),
        _passwordTextField(context, state),
        const SizedBox(height: 24),
        _authRequestButton(context, state),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: Text(
            'or sign up with'.toUpperCase(),
            style: const TextStyle(letterSpacing: 2),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Assets.img.icons.google.image(width: 36, height: 36),
              Assets.img.icons.facebook.image(width: 36, height: 36),
              Assets.img.icons.twitter.image(width: 36, height: 36),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginWidget(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: lightTheme.textTheme.headline4,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Sign in with your account',
          style: lightTheme.textTheme.subtitle1!.apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        _usernameTextField(context),
        const SizedBox(
          height: 8,
        ),
        _passwordTextField(context, state),
        const SizedBox(height: 24),
        _authRequestButton(context, state),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Text.rich(
            TextSpan(text: 'Forget your password?', children: [
              TextSpan(
                text: '\t\t\t Reset here',
                style: TextStyle(
                    color: lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ]),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Center(
          child: Text(
            'or sign in with'.toUpperCase(),
            style: const TextStyle(letterSpacing: 2),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Assets.img.icons.google.image(width: 36, height: 36),
              Assets.img.icons.facebook.image(width: 36, height: 36),
              Assets.img.icons.twitter.image(width: 36, height: 36),
            ],
          ),
        )
      ],
    );
  }

  Widget _authRequestButton(BuildContext context, AuthState state) {
    return ButtonComponent(
      width: double.infinity,
      height: 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: state.isLoading
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  width: 24,
                  height: 24,
                  child:  CircularProgressIndicator(color: lightTheme.colorScheme.onPrimary,),
                ),
                const SizedBox(width: 16,),
                Text((state.authMode == AuthMode.login ? 'log in' : 'sign up')
                    .toUpperCase())
              ],
            )
          : Text((state.authMode == AuthMode.login ? 'log in' : 'sign up')
              .toUpperCase()),
      voidCallback: () {
        context.read<AuthBloc>().add(AuthRequested(
            context: context,
            username: _userNameController.text,
            password: _passwordController.text,
            fullname: state.authMode == AuthMode.signup
                ? _fullnameController.text
                : null));
      },
    );
  }

  Widget _usernameTextField(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: emailValidator,
      focusNode: _usernameFocus,
      keyboardType:TextInputType.emailAddress,
      controller: _userNameController,
      onEditingComplete: () {
        _usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      onFieldSubmitted: (term) {
        _usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      decoration: const InputDecoration(
        label: Text('Username'),
      ),
    );
  }

  Widget _passwordTextField(BuildContext context, AuthState state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType:TextInputType.visiblePassword,
      validator: passwordValidator,
      controller: _passwordController,
      decoration: InputDecoration(
          label: const Text('Password'),
          suffixIcon: TextButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(AuthObscurePassword(isObscure: state.isObscure));
            },
            child: state.isObscure ? Text('Show') : Text('Hide'),
          )),
      autocorrect: false,
      enableSuggestions: false,
      obscureText: state.isObscure,
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _fullnameController.dispose();
    _usernameFocus.dispose();
    _fullnameFocus.dispose();
    super.dispose();
  }
}
