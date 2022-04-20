import 'package:flutter/material.dart';
import 'package:test_02/model/user_data.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key,required this.userData}) : super(key: key);
  final List<UserData> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Screen"),),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true, itemCount: userData.length, separatorBuilder: (BuildContext context, int index) { 
          return const SizedBox(height: 16,);
      }, itemBuilder: (BuildContext context, int index) { 
          return Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userData[index].label ?? '',style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(.5)),),
              const SizedBox(height: 12,),
              Text(userData[index].data ?? '',style: const TextStyle(fontSize: 20,color: Colors.black),),
            ],
          );
      },
        
      ),
    );
  }
}
