import 'package:covid_tracker/countrydata.dart';
import 'package:covid_tracker/worlddata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import "enums/screen_type.dart";

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int critical = 0;
  int recovered = 0;
  int deaths = 0;

  String country = "india";
  String countryname = "world";
  int total = 0;
  String error = "";
  String lastupdate;
  String code;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Worlddata> data = await getworldstats();
      print(data.toString());
      if (data.length == 0) {
        setState(() {
          error = "please enter a valid country name";
        });
      } else {
        setState(() {
          countryname = "world";
          error = "";
          critical = int.parse(data[0].critical);
          deaths = int.parse(data[0].deaths);
          total = int.parse(data[0].total);
          recovered = int.parse(data[0].recoveredcases);
          lastupdate = data[0].lastupdate;
        });
      }
      print(data.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    int active = (total - recovered);
    Map<String, double> dataMap = {
      "Active Cases ($active)": active.toDouble(),
      "Recovered ($recovered)": recovered.toDouble(),
      "Deaths ($deaths)": deaths.toDouble(),
      // "Xamarin": 2,
      // "Ionic": 2,
    };
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    return Form(
      key: formkey,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Covid Tracker"),
        // ),
        body: ListView(
          children: [
            SizedBox(
              height: height / 60.6,
            ),
            Row(
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.globe),
                    color: Colors.blueAccent,
                    onPressed: () async {
                      List<Worlddata> data = await getworldstats();
                      print(data.toString());
                      if (data.length == 0) {
                        setState(() {
                          error = "please enter a valid country name";
                        });
                      } else {
                        setState(() {
                          countryname = "world";
                          error = "";
                          critical = int.parse(data[0].critical);
                          deaths = int.parse(data[0].deaths);
                          total = int.parse(data[0].total);
                          recovered = int.parse(data[0].recoveredcases);
                          lastupdate = data[0].lastupdate;
                        });
                      }
                      print(data.length);
                    }),
                Text(
                  "| ",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Container(
                  width: width - 120,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width / 54,
                        left: width / 54,
                        top: height / 102,
                        bottom: height / 102),
                    child: TextFormField(
                      validator: (val) {
                        return val.isEmpty
                            ? "please enter a country name"
                            : null;
                      },
                      onChanged: (val) {
                        setState(() {
                          country = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Country Name",
                        hintStyle: TextStyle(
                          color: Color(0xff03dac6),
                        ),
                      ),
                      //     enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(width / 43.2),
                      //         borderSide: BorderSide(
                      //           color: Colors.black,
                      //         ))),
                    ),
                  ),
                  height: 80,
                ),
                IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      print("ssssssssssssssssss");
                      List<Countrydata> data = await gettotalstats();

                      print(data.toString());
                      if (data.length == 0) {
                        setState(() {
                          error = "please enter a valid country name";
                        });
                      } else {
                        setState(() {
                          countryname = country;
                          error = "";
                          critical = int.parse(data[0].critical);
                          deaths = int.parse(data[0].deaths);
                          total = int.parse(data[0].total);
                          recovered = int.parse(data[0].recoveredcases);
                          lastupdate = data[0].lastupdate;
                          code = data[0].code;
                        });
                      }
                      print(data.length);
                    })
              ],
            ),
            error != ""
                ? Padding(
                    padding: EdgeInsets.only(left: width / 54),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: EdgeInsets.only(top: height / 102),
              child: Center(
                child: Text(
                  countryname.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width / 14.4,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 81.6,
                      bottom: height / 81.6,
                      left: width / 43.2,
                      right: width / 43.2),
                  child: Container(
                    height: height / 5.44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black45,
                    ),
                    width: width / 2.21,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Critical Cases",
                          style: TextStyle(
                              color: Color(0xff03dac6),
                              fontSize: width / 14.4,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width / 54,
                              left: width / 54,
                              top: height / 102,
                              bottom: height / 102),
                          child: Text(critical.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: width / 14.4,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffff0266))),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 81.6,
                      bottom: height / 81.6,
                      left: width / 43.2,
                      right: width / 43.2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black45,
                    ),
                    height: height / 5.44,
                    width: width / 2.21,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Recovered",
                            style: TextStyle(
                                color: Color(0xff03dac6),
                                fontSize: width / 14.4,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width / 54,
                              left: width / 54,
                              top: height / 102,
                              bottom: height / 102),
                          child: Text(recovered.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: width / 14.4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(
                dataMap: dataMap,
                colorList: [
                  Colors.orangeAccent,
                  Color(0xff03dac6),
                  Colors.red,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black45,
                ),
                height: height / 5.44,
                width: width - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Cases",
                        style: TextStyle(
                            color: Color(0xff03dac6),
                            fontSize: width / 14.4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width / 54,
                          left: width / 54,
                          top: height / 102,
                          bottom: height / 102),
                      child: Text(total.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: width / 14.4,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                    ),
                  ],
                ),
              ),
            ),
            lastupdate != null
                ? Text(" last updated:$lastupdate",
                    style:
                        TextStyle(color: Colors.grey, fontSize: width / 30.85))
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> gettotalstats() async {
    Map<String, String> requestheaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      // 'x-rapidapi-host': 'covid-19-data.p.rapidapi.com',
      // 'x-rapidapi-key': 'd5da9b732dmsh6ac2ad43eeaa0e4p13e326jsn0d2620e15eb8'
    };
    var url =
        Uri.parse("https://covid19-api.com/country?name=$country&format=json");
    http.Response response = await http.get(url, headers: requestheaders);
    print(response.body);
    var jsondata = jsonDecode(response.body);
    List<Countrydata> countrydata = [];
    print(
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(jsondata.toString());
    print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    print(jsondata[0]["country"]);
    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
    for (int i = 0; i < jsondata.length; i++) {
      Countrydata countrysdata = Countrydata(
          jsondata[i]["country"].toString(),
          jsondata[i]["code"].toString(),
          jsondata[i]["confirmed"].toString(),
          jsondata[i]["recovered"].toString(),
          jsondata[i]["critical"].toString(),
          jsondata[i]["deaths"].toString(),
          jsondata[i]["lastUpdate"].toString());
      countrydata.add(countrysdata);
    }
    print(countrydata.toString());
    return countrydata;
  }

  Future<dynamic> getworldstats() async {
    Map<String, String> requestheaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'x-rapidapi-host': 'covid-19-data.p.rapidapi.com',
      'x-rapidapi-key': 'd5da9b732dmsh6ac2ad43eeaa0e4p13e326jsn0d2620e15eb8'
    };
    var url = Uri.parse("https://covid-19-data.p.rapidapi.com/totals");
    http.Response response = await http.get(url, headers: requestheaders);
    print(response.body);
    var jsondata = jsonDecode(response.body);
    List<Worlddata> worlddata = [];
    print(
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(jsondata.toString());
    print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    // print(jsondata[0]["country"]);
    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
    for (int i = 0; i < jsondata.length; i++) {
      Worlddata worldsdata = Worlddata(
          // jsondata[i]["country"].toString(),
          // jsondata[i]["code"].toString(),
          jsondata[i]["confirmed"].toString(),
          jsondata[i]["recovered"].toString(),
          jsondata[i]["critical"].toString(),
          jsondata[i]["deaths"].toString(),
          jsondata[i]["lastUpdate"].toString());
      worlddata.add(worldsdata);
    }
    print(worlddata.toString());
    return worlddata;
  }
}
