class PostList {
  final List<Post> posts;

  PostList({required this.posts});
  factory PostList.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> postsJson = parsedJson['posts'] as List;
    List<Post> posts = <Post>[];
    posts = postsJson.map((e) => Post.fromJson(e)).toList();

    return PostList(posts: posts);
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;
  List<String>? tags;

  Post(
      {required this.id,
      required this.body,
      required this.title,
      required this.userId,
      required this.tags});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        body: json['body'],
        title: json['title'],
        userId: json['userId'],
        tags: json['tags'].cast<String>());
  }
}
