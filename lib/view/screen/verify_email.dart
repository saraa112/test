
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/originalbutton.dart';
import 'entering_data.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified=false;
  Timer? timer;
   @override
   void initState()
   {
     timer=Timer.periodic(Duration(seconds: 3),
             (timer) {
             checkEmailVerified();
             });
   }
   @override
   void dispose(){
     timer?.cancel;
     super.dispose();
   }

  Future checkEmailVerified()
  async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
     isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified){
      timer?.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
     if(isEmailVerified)
       {
        return EnteringData();
       }
     else {
     return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ادخل رمز التفعيل الذى تم ارساله الى بريدك الالكنرونى'),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'رمز التفعيل'
                  ),
                ),
              const SizedBox(height: 30),

              OriginalButton(text:'إعادة ارسال رمز التغعيل',
                  onpressed:(){
                setState(() {
                  verifyEmail();
                });
                  },
                  textcolor:Colors.white ,
                  bgcolor:Colors.black)
            ],
          ),
        ),
      ) ,
    );
     }
  }
}
verifyEmail()
async{
  final user=FirebaseAuth.instance.currentUser;
  await user?.sendEmailVerification();
}

