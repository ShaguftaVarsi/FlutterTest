import 'package:flutter/material.dart';
import 'package:html/parser.dart' as htmlParser;

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie['image']?['medium'] ?? ''),
            SizedBox(height: 10),
            Text(movie['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(removeHtmlTags(movie['summary'] ?? '')),
            SizedBox(height: 10),
            Text("Genres: ${movie['genres'].join(', ')}"),
            Text("Rating: ${movie['rating']['average'] ?? 'N/A'}"),
            Text("Runtime: ${movie['runtime'] ?? 'N/A'} min"),
          ],
        ),
      ),
    );
  }
}

// Function to remove HTML tags
String removeHtmlTags(String htmlString) {
  var document = htmlParser.parse(htmlString);
  return document.body?.text ?? ''; // Extracts plain text from the HTML
}

