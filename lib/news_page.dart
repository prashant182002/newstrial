import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const URL = "https://newsapi.org/v2";

class NewsPage extends StatefulWidget {
  static const String id = 'NewsPage';
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>{
  final TextEditingController _controller = TextEditingController();
  String _title = "Empty";
  String _description = "Empty";
  String _publishedAt = "Empty";
  var _source = "";
  var _image = "";
  int _length = 0;
  var response;
  var _timeDiff = 0;
  var _apiMonth=01;
  var _apiDay=21;
  var _apiYear=2023;
  String _topic = "abc";
  Future getNews() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    _apiMonth = date.month - 1;
    _apiDay = date.day;
    _apiYear = date.year;
    http.Response res = await http.get(
      Uri.parse(
          "$URL/everything?q={$_topic}&from={$_apiYear-$_apiMonth-$_apiDay}&sortBy=popularity&apiKey=2b1327a0eb374781868dc6c7fa1ae324"),
    );
    switch (res.statusCode) {
      case 200:
        return jsonDecode(res.body);
      case 400:
        print("Bad Request");
        break;
      case 401:
        print("Unauthorized");
        break;
      case 403:
        print("Forbidden");
        break;
      case 404:
        print("Not Found");
        break;
      case 500:
        print("Internal Server Error");
        break;
      default:
        return;
    }
  }
  _newsflash() async {
    _topic = 'abc';
    response = await getNews();
    setState(() {
      _length = response["articles"].length;
    });
  }
  void initState() {
    super.initState();
    _newsflash();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.blue[700],

        ),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 10,
            child: TextField(
              onSubmitted: (val) async {
                _topic = val;
                response = await getNews();
                setState(() {
                  _length = response["articles"].length;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search in Feed',
                hintStyle: TextStyle(color: Colors.blue[700]),
                prefixIcon: Icon(Icons.search,color: Colors.blue[700],),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: _length,
              itemBuilder: (context, index) {
                DateTime now = DateTime.now();
                DateTime date = DateTime(now.year, now.month, now.day);
                _title = response['articles'][index]['title'];
                _description = response['articles'][index]['description'];
                _publishedAt = response['articles'][index]['publishedAt'];
                _source = response['articles'][index]['source']['name'];
                _image = response['articles'][index]['urlToImage'];
                _timeDiff = date.microsecondsSinceEpoch - DateTime.parse(_publishedAt).microsecondsSinceEpoch;
                _timeDiff = _timeDiff ~/ 1000000;
                _timeDiff = _timeDiff ~/ 86400;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 130,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Text("${_timeDiff.toString()} days ago",style:TextStyle(color: Colors.grey,fontSize: 10)),
                                        SizedBox(width: 10,),
                                        Text(_source, style:TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 12),),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(_title, style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.blue[700]),maxLines: 2,),
                                    SizedBox(height: 8),
                                    Expanded(
                                      child: Text(_description,style: TextStyle(fontSize:10,color: Colors.blue[600]),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 80,
                              width: 100,
                                child: Image.network(_image)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
