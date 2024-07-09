import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quicktouch/homeController.dart';

class HomePage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GiphyController _giphyController = Get.put(GiphyController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.90,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Giphy...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      String searchQuery = _searchController.text.trim();
                      if (searchQuery.isNotEmpty) {
                        _giphyController.resetAndFetchGifs(searchQuery);
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    _giphyController.resetAndFetchGifs(value.trim());
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_giphyController.isLoading.value && _giphyController.gifs.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
            
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    _giphyController.fetchGifs();
                  }
                  return true;
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: _giphyController.gifs.length,
                  itemBuilder: (context, index) {
                    final gif = _giphyController.gifs[index];
                    final gifUrl = gif['images']['fixed_height']['url'];
                    return Image.network(gifUrl);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}