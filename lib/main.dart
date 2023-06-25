import 'package:assignment_alisoft/bloc/bloc/auth_bloc.dart';
import 'package:assignment_alisoft/bloc/bloc/auth_event.dart';
import 'package:assignment_alisoft/bloc/bloc/auth_state.dart';
import 'package:assignment_alisoft/home_page.dart';
import 'package:assignment_alisoft/login_page.dart';
import 'package:assignment_alisoft/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'configs/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Assignment Alisoft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryLight),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
        child: const LoaderOverlay(child: Content()),
      ),
      routes: {
        '/login-page': (context) => const LoginPage(),
        '/home-page': (context) => const HomePage(),
      },
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          context.loaderOverlay.show();
        } else {
          debugPrint(
              'afah else ${state.isLoading.toString()} ${state.toString()}');
          context.loaderOverlay.hide();
        }
        debugPrint('afah ${state.isLoading.toString()} ${state.toString()}');
      },
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return const LoginPage();
        } else if (state is AuthStateLoggedIn) {
          return const HomePage();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
