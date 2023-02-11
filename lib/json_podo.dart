import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:podo_practice/posts.dart';

import 'display.dart';

class JsonParsingPodo extends StatefulWidget {
  const JsonParsingPodo({super.key});

  @override
  State<JsonParsingPodo> createState() => _JsonParsingPodoState();
}

class _JsonParsingPodoState extends State<JsonParsingPodo> {
  late Future<PostList> data;

  @override
  void initState() {
    super.initState();
    Network network = Network("https://dummyjson.com/posts");
    data = network.loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("PODO: json"),
        ),
        body: Center(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<PostList> snapshot) {
                  List<Post> allposts;
                  if (snapshot.hasData) {
                    allposts = snapshot.data!.posts;
                    return createListView(allposts, context);
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ));
  }

  Widget createListView(List<Post> data, BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, int index) {
          Post post = data[index];
          return Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    title: Text(data[index].title),
                    leading: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 23,
                          child: Text("${data[index].id}"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayData(post: post)),
                      );
                    },
                    trailing: const Text("..."),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> loadPost() async {
    final response = await get(Uri.parse(Uri.encodeFull(url)));

    if (response.statusCode == 200) {
      //ok
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data. ");
    }
  }
}
