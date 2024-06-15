import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:glumate_flutter/presentation/pages/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/Chat/chatModel.dart';
import 'package:glumate_flutter/presentation/Design/colors.dart';
import 'package:glumate_flutter/presentation/home_view.dart';
import 'package:glumate_flutter/presentation/Chat/members.dart';
import 'package:glumate_flutter/presentation/Chat/receiver_row_view.dart';
import 'package:glumate_flutter/presentation/Chat/sender_row_view.dart';

class MyChatUI extends StatefulWidget {
  const MyChatUI({Key? key}) : super(key: key);

  @override
  MyChatUIState createState() => MyChatUIState();
}

int _currentPageIndex = 0;

var url = 'https://i.pinimg.com/736x/fd/6e/04/fd6e04548095d7f767917f344a904ff1.jpg';
var urlTwo = 'https://sguru.org/wp-content/uploads/2017/03/cute-n-stylish-boys-fb-dp-2016.jpg';

class MyChatUIState extends State<MyChatUI> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset != scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  void _openFileExplorer() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      // Do something with the selected file
    }
  } catch (e) {
    print("Error picking file: $e");
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F3),
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: TColor.primaryColor1,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
              );
            },
          ),
        ),
        leadingWidth: 20,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          title: const Text(
            'Hanine Bouguerra',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            'online',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatModelList.length,
                    itemBuilder: (context, index) => chatModelList.elementAt(index).isMee
                        ? SenderRowView(
                            index: index,
                          )
                        : ReceiverRowView(
                            index: index,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0, left: 8),
                        child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Color.fromARGB(255, 102, 127, 217),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: 6,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          controller: controller,
                          onFieldSubmitted: (value) {
                            controller.text = value;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            hintText: 'Type a message',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 10),
                        child: Transform.rotate(
                          angle: 45,
                          child: IconButton(
                            icon: const Icon(
                              Icons.attachment_outlined,
                              color: Color.fromARGB(255, 102, 127, 217),
                            ),
                            onPressed: _openFileExplorer,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            chatModelList.add(ChatModel(controller.text, true));
                            animateList();
                            controller.clear();
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            chatModelList.add(ChatModel(controller.text, false));
                            animateList();
                            controller.clear();
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 8, right: 8),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 102, 127, 217),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
