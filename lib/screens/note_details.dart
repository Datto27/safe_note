import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/note.dart';


// this screen is used for add or update note
class NoteDetails extends StatefulWidget {

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void saveNote() async {}

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    if (routeArgs["currNote"] != null) {
      titleController.text = routeArgs["currNote"].title;
      descriptionController.text = routeArgs["currNote"].description;
    }
  

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title'], style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Enter note title",
                ),
              ),
              const SizedBox(height: 20,),
              TextField(  // multiline input like textarea
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 15,
                decoration: InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 25),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                   if (routeArgs['title'] == "Create Note") {
                    print("-------------------- clicked --------------------------");
                    await DatabaseHelper.instance.addNote(
                      Note(title: titleController.text, 
                            description: descriptionController.text)
                    );
                  } else {
                    await DatabaseHelper.instance.updateNote(
                      Note(
                        id: routeArgs["currNote"].id,
                        title: titleController.text,
                        description: descriptionController.text,
                      )
                    );
                  }
                  Navigator.of(context).pushReplacementNamed("/home");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}