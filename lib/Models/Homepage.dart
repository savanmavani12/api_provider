import 'package:api_provider/Global/Global.dart';
import 'package:api_provider/Helpers/Helper.dart';
import 'package:api_provider/Models/Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:  Colors.teal,
        actions: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                onSubmitted: (val) {
                  setState(() {
                    Global.searchData = int.parse(val) - 1;
                  });
                },
                placeholder: "Search Id",
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton(
              color: Colors.white,
              elevation: 2,
              onSelected: (val) {
                setState(() {
                  Global.endpoint = val;
                  Global.title = val;
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: "/post",
                    child: Text("Post"),
                  ),
                  const PopupMenuItem(
                    value: "/comments",
                    child: Text("Comments"),
                  ),
                  const PopupMenuItem(
                    value: "/albums",
                    child: Text("Albums"),
                  ),
                  const PopupMenuItem(
                    value: "/photos",
                    child: Text("Photos"),
                  ),
                  const PopupMenuItem(
                    value: "/todos",
                    child: Text("Todos"),
                  ),
                  const PopupMenuItem(
                    value: "/users",
                    child: Text("User"),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      backgroundColor:  Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                  ),
                  child: Text(
                    Global.title.substring(1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: APIHelpers.apiHelpers.getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error is : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Provider>? data = snapshot.data;
                    return (data != null)
                        ? (Global.searchData.toInt() < data.length)
                        ? Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color:  Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        "${data[Global.searchData].id}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child:(Global.endpoint != '/users')?Text(
                                        data[Global.searchData].userid.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ):Text(
                                        data[Global.searchData].username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[Global.searchData].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : const Center(
                      child: Text("Invalid Search id ..."),
                    )
                        : const Center(
                      child: Text("Data is Not Founds ...."),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
