import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  TextEditingController searchController = TextEditingController();

  searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onSubmitted: searchMovies,
          decoration: InputDecoration(
            hintText: 'Search Movies',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: searchResults.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var movie = searchResults[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
            child: Card(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Image.network(movie['image']?['medium'] ?? '', height: 100),
                  Text(movie['name'], style: Theme.of(context).textTheme.bodyLarge),
                  Text(movie['summary'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
