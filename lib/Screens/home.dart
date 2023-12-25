import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'news.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  Future<News> fetchNews() async {
    final url = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-25&sortBy=publishedAt&apiKey=1594a29c5a4447dc8c49ee38afc0d2b8";

    var respons = await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      final result = jsonDecode(respons.body);
      return News.fromJson(result);
    }
    else {
      return News();
    }
  }


  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
        appBar: AppBar(
        title: Text('News App'),
    centerTitle: true,
    ),
  body: FutureBuilder(future: fetchNews(), builder: (context,snapshot){
    return ListView.builder(itemBuilder: (context,index){
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage("${snapshot.data!.articles![index].urlToImage}"),
        ),
        title: Text("${snapshot.data!.articles![index].title}"),
        subtitle: Text("${snapshot.data!.articles![index].description}"),
      );

    },
    itemCount: snapshot.data!.articles!.length ,
    );
  }),



    );
  }
}


