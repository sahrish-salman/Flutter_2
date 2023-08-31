import 'package:flutter/material.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  List friendList = ["Sahrish", "Salman", "Shahrukh"];

  TextEditingController itemController = TextEditingController();
  TextEditingController updateItemController = TextEditingController();

  addItem() {
    setState(() {
      if (itemController.text.isNotEmpty) {
        friendList.add(itemController.text);
      }
    });

    itemController.clear();
  }

  deleteItem({required i}) {
    setState(() {
      friendList.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: itemController,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 50,
              ),
              ListView.builder(
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.blueGrey,
                    title: const Text(
                      "friendList[index]",
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            updateItemController.text = friendList[index];
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Update Dialog"),
                                  content: TextField(
                                    controller: updateItemController,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          friendList[index] =
                                              updateItemController.text;
                                        });
                                        updateItemController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Update"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteItem(i: index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: const Text("Add"),
      ),
    );
  }
}
