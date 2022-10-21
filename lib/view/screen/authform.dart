import 'dart:convert';
import 'package:concrete/view/screen/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/log_in/login_cubit.dart';
import '../../blocs/store_data/store_data_cubit.dart';
import '../../core/enums/toast_states.dart';
import '../../core/shared/app_naviagtor.dart';
import '../../core/shared/toast/toast_config.dart';
import '../widget/originalbutton.dart';
import '../widget/students.dart';
import 'entering_data.dart';
import 'package:http/http.dart' as http;


class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();

}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  String _email = '', _password = '';
  bool keepMeLoggedIn = false;
  bool ishiddenpassword = true;
  bool isEmailVerified=false;


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<StoreDataCubit, StoreDataState>
      (listener: (context, state) {},

        builder: (context, state) {
          var storecubit = StoreDataCubit.get(context);
          storecubit.getUserData();
          return
            Form(
                key: _formkey,
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      TextFormField(
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) =>
                        ((value!.isEmpty) && !(value.contains('@')))
                            ? 'ادخل بريد الكتروني صالح للاستخدام'
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'اكتب البريد الالكتروني',
                          prefixIcon: Icon(Icons.mail),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        onChanged: (value) => _password = value,
                        validator: (value) =>
                        value!.length < 6
                            ? 'كلمة المرور يجب ان تتكون من 6 علي الاقل '
                            : null,
                        decoration: InputDecoration(
                            labelText: 'اكتب كلمة المرور',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ishiddenpassword = !ishiddenpassword;
                                  });
                                },
                                child: ishiddenpassword
                                    ? Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: ishiddenpassword,
                      ),
                      const SizedBox(height: 20,),

                      BlocConsumer<LoginCubit,LoginState>
                        ( listener:(context,state){},
                        builder:(context,state) {
                          var cubit = LoginCubit.get(context);
                          return OriginalButton(
                            text: 'تسجيل الدخول',
                            onpressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await cubit.signInWithEmailAndPassword(
                                    _email, _password);

                                isEmailVerified =
                                    FirebaseAuth.instance.currentUser!.emailVerified;}
                                  if (!isEmailVerified)
                                  {
                                    verifyEmail();
                                    AppNavigator.customNavigator(
                                        context: context,
                                        screen:  EnteringData(),
                                        finish: true);
                                    }
                                  else {
                                  if (FirebaseAuth.instance.currentUser
                                      ?.email == 'ahmedelkyal1@gmail.com')
                                  {
                                    AppNavigator.customNavigator(
                                        context: context,
                                        screen: Students(sreeamStudents: storecubit
                                            .streamStudents,
                                            userMail: storecubit.user!.email)
                                        , finish: true);
                                  }
                                  else {
                                    AppNavigator.customNavigator(
                                        context: context,
                                        screen: EnteringData(),
                                        finish: true);
                                  }
                                  }
                            },
                            textcolor: Colors.white,
                            bgcolor: Colors.lightBlue,
                          );
                        }),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('تذكرني ؟'),
                          Checkbox(
                              value: keepMeLoggedIn,
                              onChanged: (value) {
                                setState(() async {
                                  keepMeLoggedIn = value!;
                                });
                              }),
                        ],
                      ),

                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('هل نسيت كلمة المرور ؟', style: TextStyle(
                              fontSize: 18
                          ),),
                          TextButton(
                              onPressed: () {
                                resetPassword();
                              },
                              child: const Text('إعادة تعيين',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 18
                                ),)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('ليس لديك حساب ؟', style: TextStyle(
                              fontSize: 18
                          ),),
                          BlocConsumer<LoginCubit,LoginState>
                           ( listener:(context,state){},
                             builder:(context,state) {
                               var cubit = LoginCubit.get(context);
                               return TextButton(
                                   onPressed: () async {
                                     if (_formkey.currentState!.validate()) {
                                       await cubit.registerWithEmailAndPassword(
                                           _email, _password);
                                       AppNavigator.customNavigator(
                                           context: context,
                                           screen: EnteringData(),
                                           finish: false);
                                     }
                                   },
                                   child: const Text('سجل الان',
                                     style: TextStyle(
                                         color: Colors.lightBlue,
                                         fontSize: 18
                                     ),));
                             }),
                        ],
                      )
                    ],
                  ),
                ));
        }
    );
  }
  verifyEmail()
  async{
    try{
      final user=FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    }catch(e)
    {
      print(e.toString());
    }
  }

  Future resetPassword() async {

    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email)
        .then((value) {
      ToastConfig.showToast(msg:'تم الارسال',
          toastStates: ToastStates.Success);}
    ).catchError((error){
      print('error is error  ${error.toString()}');
    });
  }
}
