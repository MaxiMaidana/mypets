import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> ls;
  final String Function(String) function;

  CustomSearchDelegate({required this.ls, required this.function});
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          query = '';
          context.pop();
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ls.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();
      if (input != '') {
        return result.contains(input);
      } else {
        return false;
      }
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            function(query);
            close(context, query);
            // showResults(context);
          },
        );
      },
    );
  }
}
