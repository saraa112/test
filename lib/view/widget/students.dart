import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Students extends StatelessWidget {
     final   sreeamStudents;
     final   userMail;
    Students({required this.sreeamStudents,required this.userMail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: sreeamStudents,
        builder: (context ,snapshot)
       {
          if(snapshot.hasData)
            {
             QuerySnapshot values= snapshot.data as QuerySnapshot;
             return ListView.separated(
               separatorBuilder: (context, index) {
                 return const Divider(color: Colors.lightBlue,height: 4,thickness: 2);
               },
                 itemCount:values.docs.length ,
                 itemBuilder: (Context,index)
             {
               return Container(
                 decoration: const BoxDecoration(
                  color: Colors.white
                 ),
                 padding: const EdgeInsets.all(8),
                 child: Column(
                   children: [
                     Text(values.docs[index]['name'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     SizedBox(width: 15),
                     Text(values.docs[index]['phone'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     SizedBox(width: 15),
                     Text(values.docs[index]['sender'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['caliber'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['cement'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['effort'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['volum'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),

                     Text(values.docs[index]['type'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['timest'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     Text(values.docs[index]['dateset'],
                       style: const TextStyle(
                           color: Colors.black,
                           fontSize: 20
                       ),),
                     //Text(values.docs[index]['time'].toString(),
                      // style: const TextStyle(
                      //     color: Colors.red,
                      //     fontSize: 20
                     //  ),),


                   ],
                 ),
               );
             }
             );
          }
          else {
            Center(
              child:
              const Text('data is empty'),
            );
            return Container();
          }});

  }
}
