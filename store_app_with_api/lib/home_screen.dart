import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'model_class/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Product> products=[];
  
  Future<List<Product>> getProducts() async {
    final response=await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      print("API hit successfully");
    //  print(data.toString());
     print(data);
      for(Map i in data){
        print(Product.fromJson(data[i]));
        Product product=Product.fromJson(data[i]);
        products.add(product);
      }
      print(products);
      return products;
    }else{
      print("Failed");
      return products;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API DATA",style: TextStyle(color: Colors.white),),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: getProducts(),
                builder: (context, snapshot){
                    if(!snapshot.hasData) {
                      return const  Center(child: CircularProgressIndicator(),);
                    }else{
                      //
                      return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Text(products[index].title.toString(),
                              style: const TextStyle(color: Colors.black),);
                          });
                    }
            }),
          )
      ],),
    );
  }
}
