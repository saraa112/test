import 'package:flutter/material.dart';
import 'authform.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:SingleChildScrollView(
          child:Column(
            children: [
              Stack(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.height*0.5,
                    decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.only(
                            bottomLeft:Radius.circular(50) ,
                            bottomRight: Radius.circular(50)
                        )
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60,),
                      const Text('أهلا بكم',style:TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),),
                      Image.asset('images/car.png',
                        width:double.infinity,),
                    ],
                  ),
                ],
              ),
              AuthForm(),
            ],
          ),
        ),
      )
    );
  }
}
