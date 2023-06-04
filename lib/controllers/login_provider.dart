import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhub/views/ui/auth/update_user.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/request/auth/login_model.dart';
import '../services/helpers/auth_helper.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get isObscureText => _obscureText;

  set isObscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }


  final loginFormKey = GlobalKey<FormState>();
  bool validateAndSave(){
    final form = loginFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  userLogin(LoginModel model){
    AuthHelper.login(model).then((response){
      if(response && firstTime){
        Get.off(()=> const PersonalDetails());
      }else if(response && !firstTime){
        Get.off(()=> const MainScreen());
      }else if(!response){
        Get.snackbar("Sign Failed", "Please Check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstTime = false;
    //removing in device memory
    await prefs.setString("token", "");
    await prefs.setString("userId", "");
    await prefs.setString("profile", "");
    await prefs.setBool("loggedIn", false);
    //await prefs.remove('token');
  }



}
