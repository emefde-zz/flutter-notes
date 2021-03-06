// Mocks generated by Mockito 5.0.14 from annotations
// in flutter_login/test/login/view/login_form_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:bloc/bloc.dart' as _i4;
import 'package:flutter_login/login/login.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLoginState_0 extends _i1.Fake implements _i2.LoginState {}

class _FakeStreamSubscription_1<T> extends _i1.Fake
    implements _i3.StreamSubscription<T> {}

/// A class which mocks [LoginBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginBloc extends _i1.Mock implements _i2.LoginBloc {
  MockLoginBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeLoginState_0()) as _i2.LoginState);
  @override
  _i3.Stream<_i2.LoginState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.LoginState>.empty())
          as _i3.Stream<_i2.LoginState>);
  @override
  _i3.Stream<_i2.LoginState> mapEventToState(_i2.LoginEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i2.LoginState>.empty())
          as _i3.Stream<_i2.LoginState>);
  @override
  void add(_i2.LoginEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.LoginEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i4.Transition<_i2.LoginEvent, _i2.LoginState>> transformEvents(
          _i3.Stream<_i2.LoginEvent>? events,
          _i4.TransitionFunction<_i2.LoginEvent, _i2.LoginState>?
              transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue: Stream<
                  _i4.Transition<_i2.LoginEvent, _i2.LoginState>>.empty())
          as _i3.Stream<_i4.Transition<_i2.LoginEvent, _i2.LoginState>>);
  @override
  void emit(_i2.LoginState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i4.Transition<_i2.LoginEvent, _i2.LoginState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i4.Transition<_i2.LoginEvent, _i2.LoginState>>
      transformTransitions(
              _i3.Stream<_i4.Transition<_i2.LoginEvent, _i2.LoginState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue: Stream<
                      _i4.Transition<_i2.LoginEvent, _i2.LoginState>>.empty())
              as _i3.Stream<_i4.Transition<_i2.LoginEvent, _i2.LoginState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i2.LoginState> listen(
          void Function(_i2.LoginState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_1<_i2.LoginState>())
          as _i3.StreamSubscription<_i2.LoginState>);
  @override
  void onChange(_i4.Change<_i2.LoginState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
