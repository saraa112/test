import 'package:flutter/material.dart';


class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final Color textcolor;
  final Color bgcolor;

  const OriginalButton({Key? key,required this.text, required this.onpressed, required this.textcolor, required this.bgcolor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width:double.infinity,
      child:TextButton(
        //color: bgcolor,
        onPressed: onpressed,
       // shape: RoundedRectangleBorder(
         //   borderRadius: BorderRadius.circular(25)
       // ),
        child: Text('$text',
          style: TextStyle(
              fontSize: 18,
              color: textcolor
          ),),
      ) ,
    );
  }
}
