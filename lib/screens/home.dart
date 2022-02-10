import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/note.dart';
import '../navigations/drawer_nav.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Note> notes = [
  //   Note(title: "title", description: "description"),
  // ];

  @override
  Widget build(BuildContext context) {
    // DatabaseHelper.instance.deleteDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<Note>>(
          // async, await, shemcvleli. daicdis iqamde sanam db-dan info-s miigebs
          future: DatabaseHelper.instance.getNotes(),
          builder: (ctx, snapshot) {
            // print("home:snapshat ==> ${snapshot.data}");
            if (!snapshot.hasData) {
              return Center(child: Text("Loading..."),);
            }
            return snapshot.data!.isEmpty
              ? Center(child: Text("No Notes in List"),)
              : ListView.builder(
                itemCount: snapshot.data!.length,
                // ------------- notes list ----------------
                itemBuilder: (ctx, i) => Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        snapshot.data![i].title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text(
                      "${snapshot.data![i].description}",
                      maxLines: 1,
                      // style: TextStyle(overflow: TextOverflow.ellipsis,),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () async {
                        DatabaseHelper.instance.removeNote(snapshot.data![i].id!);
                        setState(() {});
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/note-details", arguments: {
                        "title": "Edit Note",
                        "currNote": snapshot.data![i]
                      });
                    },
                  )
                ),
              );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/note-details", arguments: {
            "title": "Create Note"
          });
        },
      )
    );
  }
}