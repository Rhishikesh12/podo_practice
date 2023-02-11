import 'package:flutter/material.dart';
import 'package:podo_practice/posts.dart';

class DisplayData extends StatefulWidget {
  final Post post;
  const DisplayData({super.key, required this.post});

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Display Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.post.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10.0,
                ),
                Text(widget.post.body,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                const SizedBox(
                  height: 20.0,
                ),
                const Text("Tags:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5.0,
                ),
                Wrap(
                  spacing: 8.0,
                  children: widget.post.tags!
                      .map((tag) => Chip(
                            label: Text(tag),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
