import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as htmlParser; // For parsing HTML strings

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async {
    final response = await http.get(
        Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: GridView.builder(
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          var movie = movies[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
            child: Card(
              color: Theme
                  .of(context)
                  .cardColor,
              child: Column(
                children: [
                  Image.network(movie['image']?['medium'] ?? '', height: 100),
                  Text(movie['name'], style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge),
                  Text(
                    removeHtmlTags(movie['summary'] ?? ''),
                    // Strip HTML from the summary
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// Function to remove HTML tags
String removeHtmlTags(String htmlString) {
  var document = htmlParser.parse(htmlString);
  return document.body?.text ?? ''; // Extracts plain text from the HTML
}

