import 'package:assignment_alisoft/bloc/bloc/auth_event.dart';
import 'package:assignment_alisoft/bloc/bloc/auth_state.dart';
import 'package:assignment_alisoft/helper/global_variables.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/post_auth_login_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateInitial(isLoading: false)) {
    on<AuthEventInitialize>(
      (event, emit) {
        emit(const AuthStateLoggedOut(isLoading: false, exception: null));
      },
    );
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true));

      final email = event.email;
      final password = event.password;
      try {
        await PostUser.connectToAPI(email, password).then((value) {
          debugPrint('afah ${value.code.toString()}');
          if (value.code == 200) {
            user = value.user!['name'];
            emit(const AuthStateLoggedIn(isLoading: false));
          }
        });
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
    on<AuthEventLogout>(
      (event, emit) {
        emit(const AuthStateLoggedOut(isLoading: false, exception: null));
      },
    );
  }
}
