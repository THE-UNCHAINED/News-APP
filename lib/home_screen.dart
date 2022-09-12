import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/news_api.dart';

import 'model.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsApiModel>? newsList;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_drop_down,
                      // color: Colors.white,
                    ),
                    SizedBox(
                      width: size.width / 4,
                    ),
                    const Text(
                      "NEWS APP",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        //color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: const CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: newsList!.length,
                          itemBuilder: (context, index) {
                            return listItems(size, newsList![index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(Size size, NewsApiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReadingNews(
              model: model,
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: size.width / 1.15,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black45),
            ),
            child: Column(
              children: [
                Container(
                  height: size.height / 4,
                  width: size.width / 1.05,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  child: model.imageUrl != ""
                      ? Image.network(
                          model.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : const Text("Cant Load image"),
                ),
                Container(
                  width: size.width / 1.1,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(model.title,
                      style: GoogleFonts.bebasNeue(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Container(
                  width: size.width / 1.1,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(model.description,
                      style: GoogleFonts.lato(color: Colors.grey[800])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
