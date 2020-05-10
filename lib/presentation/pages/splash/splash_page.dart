import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inviu_flutter/application/auth/auth_bloc.dart';
import 'package:inviu_flutter/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          // authenticated: (_) =>
          //     // Router.navigator.pushReplacementNamed(Router.notesOverviewPage),
          unauthenticated: (_) =>
              Router.navigator.pushReplacementNamed(Router.signInPage),
        );
      },
      child: _PageWidget(),
    );
  }
}

class _PageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
