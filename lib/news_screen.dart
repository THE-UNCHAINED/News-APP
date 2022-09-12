import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model.dart';

class ReadingNews extends StatelessWidget {
  final NewsApiModel model;

  const ReadingNews({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: size.width / 1.05,
                  child: Text(model.title,
                      style: GoogleFonts.bebasNeue(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Container(
                  height: size.height / 3,
                  width: size.width / 1.05,
                  alignment: Alignment.center,
                  child: model.imageUrl != ""
                      ? Image.network(
                          model.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          "Unable to load image",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Container(
                  width: size.width / 1.05,
                  child: Text(model.content,
                      style: GoogleFonts.lato(
                          fontSize: 18, color: Colors.grey[800])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
