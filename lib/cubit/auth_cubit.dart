import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

part "auth_state.dart";

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
//username
  final _nameC = BehaviorSubject<String>();
  Stream<String> get nameStream => _nameC.stream;
  bool checkUserValidation() {
    if (_nameC.hasError == false && _nameC.hasValue == false) {
      _nameC.sink.addError("user name is required.");
      return false;
    }

    return true;
  }

  updateName(String text) {
    if (text.isEmpty) {
      _nameC.sink.addError("User name cannot be empty");
    } else if (text.length < 5) {
      _nameC.sink.addError("Please enter your full name");
    } else {
      _nameC.sink.add(text);
    }
  }
  //phone number

  final _phoneC = BehaviorSubject<String>();
  Stream<String> get phoneStream => _phoneC.stream;
  bool checkPhoneValidation() {
    if (_phoneC.hasError == false && _phoneC.hasValue == false) {
      _phoneC.sink.addError("phone is required.");
      return false;
    }

    return true;
  }

  updatePhone(String text) {
    if (text.isEmpty) {
      _phoneC.sink.addError("Phone number cannot be empty");
    } else if (text.length != 10) {
      _phoneC.sink.addError("Enter a 10 digit phone number");
    } else {
      _phoneC.sink.add(text);
    }
  }

  //print
  void onNext() {
    debugPrint("Phone number =${_phoneC.value.toString()}");
    debugPrint("Name =${_nameC.value}");
  }
  //validate button

  Stream<bool> get buttonValid =>
      Rx.combineLatest2(nameStream, phoneStream, (a, b) => true);
}
