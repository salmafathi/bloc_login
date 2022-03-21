import 'dart:async';
import 'dart:math';
import 'package:bloc_login/data/constants/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bloc_login/data/models/user_model.dart';
import '../../../../data/repositories/authentication_sharedPref_repository/authentication_sharedPref_repository.dart';
import 'auth_state.dart';
part 'auth_shared_event.dart';

class AuthSharedBloc extends HydratedBloc<AuthSharedEvent, AuthState> {
  AuthSharedBloc({AuthenticationSharedPrefRepository authenticationRepository}) : _authenticationRepository = authenticationRepository, super(AuthInitial()) {
    // handle auth init
    on<AuthSharedInit>(_onAuthenticationInit);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthSharedLoginRequested>(_onAuthenticationLoginRequested);
    on<AuthRefreshRequested>(_onAuthenticationLoginRefresh);
    on<Authenticated>(_onAuthenticated);
    on<AuthSharedRegisterRequested>(_onAuthenticationRegisterRequested);
    on<AuthForgotPasswordRequested>(_onAuthenticationForgotPasswordRequested);
    on<UpdatePasswordRequested>(_onAuthenticationUpdatePasswordRequested);
  }

  final AuthenticationSharedPrefRepository _authenticationRepository;

  Future<FutureOr<void>> _onAuthenticationInit(AuthSharedInit event, Emitter<AuthState> emit) async {
    // check if current state is AuthGranted
    // if AuthGranted -> preserve state
    // else emit AuthInitial state
    emit(state is AuthGranted ?  state : AuthInitial());
  }

  Future<FutureOr<void>> _onAuthenticationLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await _authenticationRepository.logOut(event.token);
    emit(AuthInitial());
  }

  Future<FutureOr<void>> _onAuthenticationLoginRequested(AuthSharedLoginRequested event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      bool authenticationStatus = await _authenticationRepository.logIn(username: event.email, password: event.password, device: event.device);
      authenticationStatus ?
        emit(AuthGranted(TOKEN, getUser(event.email)))
       : emit(const AuthDenied(["Login failed"]));
  }


  Future<FutureOr<void>> _onAuthenticationRegisterRequested(AuthSharedRegisterRequested event, Emitter<AuthState> emit) async {
    emit(const RegisterLoading());
     await _authenticationRepository.register(email: event.email, password: event.password, cpassword: event.cpassword)
        .then((value){
          value? emit(RegisterGranted(event.email)) : emit(const RegisterDenied());
        });
  }

  Future<FutureOr<void>> _onAuthenticationForgotPasswordRequested(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
   emit(const ForgotPasswordLoading());
   await _authenticationRepository.forgotPassword(email: event.email)
   .then((value){
     if(value)
       {
         Random random = new Random();
         emit(ForgotPasswordGranted(random.nextInt(10000)+10000));
       }
     else{
       emit(ForgotPasswordError('No matching email ! Try again or Sign up please'));
     }
   });

  }

  Future<FutureOr<void>> _onAuthenticationUpdatePasswordRequested(UpdatePasswordRequested event, Emitter<AuthState> emit) async {
    await _authenticationRepository.updatePassword(password: event.password)
        .then((value){
          value? emit(const UpdatePasswordGranted()) : emit(const UpdatePasswordDenied());
    });
  }


  FutureOr<void> _onAuthenticated(Authenticated event, Emitter<AuthState> emit) {
    emit(AuthGranted(event.token, event.user));
  }

  Future<FutureOr<void>> _onAuthenticationLoginRefresh(AuthRefreshRequested event, Emitter<AuthState> emit) async {

  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      return AuthGranted.fromMap(json);
    } catch (_) {
      return AuthInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if(state is AuthGranted){
      return state.toMap();
    }else{
      return null;
    }
  }
}
