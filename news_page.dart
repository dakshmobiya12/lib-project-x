import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/feed_item_model.dart';
import '../model/news_api_model.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  static List<Article> contentList = [];

  // static List<ContentModel> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(158, 158, 158, 0.25),
        padding:
            const EdgeInsets.only(bottom: 25, right: 25, left: 25, top: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print('has data');
                      return ListView.separated(
                          padding:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 226,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          // color: const Color.fromRGBO(158, 158, 158,0.25),
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            color: Colors.redAccent,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                                height: 5,
                                              ),
                                              const Icon(
                                                  Icons.star_border_outlined,
                                                  size: 30,
                                                  color: Colors.white),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                  width: 210.8,
                                                  child: Text(
                                                    contentList[index]
                                                        .title
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Icon(
                                                //items[index].icon,
                                                Icons.newspaper,
                                                size: 25,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Image.network(contentList[index]
                                                .urlToImage
                                                .toString())),
                                        const Divider(),
                                        Container(
                                          height: 30,
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5))),
                                            color: Colors.redAccent,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 50,
                                                height: 0,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   if (items[index]
                                                    //       .isLiked!) {
                                                    //     items[index].likes += 1;
                                                    //     items[index].isLiked =
                                                    //         false;
                                                    //   } else if (!items[index]
                                                    //       .isLiked!) {
                                                    //     items[index].likes -= 1;
                                                    //     items[index].isLiked =
                                                    //         true;
                                                    //   }
                                                    // });
                                                  },
                                                  child: const Icon(
                                                    /* items[index].isLiked!
                                                         ? Icons
                                                             .thumb_up_alt_outlined
                                                         : */Icons.thumb_up,
                                                    size: 25,
                                                    color: Colors.white,
                                                  )),
                                              const Text(
                                                  "5",
                                                  style:  TextStyle(
                                                      color: Colors.white)),
                                              // SizedBox(width: 70,height: 5),
                                              // InkWell(child: Icon(Icons.comment,size: 25,color: Colors.white,)),
                                              const SizedBox(
                                                width: 70,
                                                height: 0,
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.share,
                                                    size: 25,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                          itemCount: contentList.length);
                    } else {
                      print('has not data');
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Article>> getData() async {
    // int i = 0;
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=811125f115444e1e9f0e49e7119930f2"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("status code 200 is done");
      print(contentList.length);
      for (Article article in data) {
         contentList.add(Article.fromJson(data));
       }
      print("return successfully");
      return contentList;
    } else {
      print("not done");

      return contentList;
    }
  }
}
