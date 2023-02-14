
import 'dart:convert';

import 'package:http/http.dart'as http;

import '../Models/meme_class.dart';

class ApiResponse{

 static  String baseUrl="https://programming-memes-reddit.p.rapidapi.com/";
  List<Meme> memeDataList=[];
 Future<List<Meme>> getRequest()async{
   var response=await http.get(Uri.parse(baseUrl),headers: {
     "X-RapidAPI-Key":"62edbcac7fmsh021657112c36057p1c6c41jsn36679b3e720a",
     "X-RapidAPI-Host":"programming-memes-reddit.p.rapidapi.com"
   });
   var data = jsonDecode(response.body);
   if(response.statusCode==200){
      print("response Successful");
      for(int i=0;i<data.length;i++) {
        Meme meme = Meme.fromJson(data[i]);
        memeDataList.add(meme);
      }
      return memeDataList;
   }else{
     print("response Failed");
     throw Exception();
   }
 }

}