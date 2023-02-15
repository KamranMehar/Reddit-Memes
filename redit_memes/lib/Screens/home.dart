import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redit_memes/Network/network_api.dart';
import 'package:redit_memes/main.dart';

import '../Models/meme_class.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiResponse apiResponse=ApiResponse();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.white,
            Colors.red,
            Colors.white,
          ],
        radius: 3
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          flexibleSpace: ClipRRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: Container(color: Colors.transparent,),),),
          backgroundColor: Colors.white.withAlpha(400),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 50,
                width: 50,
                child: Image.asset('lib/assets/reddit_logo.png'),
              ),
               const Text("Reddit Memes",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
  body: RefreshIndicator(
    onRefresh: (){
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(a,b,c)=>MyApp(),
          transitionDuration: const Duration(seconds: 0)));
      return Future.value(false);
    },
    child: FutureBuilder(
          future: apiResponse.getRequest(),
          builder: (context,AsyncSnapshot<List<Meme>> snap){
            if(snap.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.red,),);
            }else if(snap.hasData){
              return ListView.builder(

                  itemCount: snap.data!.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(snap.data![index].subredditName??"",style: const TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,fontSize: 15),),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height*2/5,
                                child: Image.network(snap.data![index].link?? "",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.amber,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Whoops!',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey.shade200,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Center(child: Text(snap.data![index].title??"",style: const TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,fontSize: 18),),),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.star,color: Colors.yellow.shade400,),
                              Text(snap.data![index].upVotes.toString(),style: const TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,fontSize: 13),)
                            ],)
                          ],
                        ),
                      ),
                    );
                  }
              );
            }else{
              return const Text("something went wrong\ncheck your network connect and try again",style: TextStyle(color: Colors.black),);
            }

    }),
  ),
      ),
    );
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
}
