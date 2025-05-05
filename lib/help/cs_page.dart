import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class CustSupport extends StatefulWidget {
  const CustSupport({super.key});

  @override
  State<CustSupport> createState() => _CustSupportState();
}

class Message {
  final String text;
  final DateTime date;
  final bool sentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.sentByMe,
  });
}

class _CustSupportState extends State<CustSupport> {
  List<Message> messages = [
    Message(
      text: "test text 2",
      date: DateTime.now().subtract(Duration(days: 2, minutes: 10)),
      sentByMe: false,
    ),
    Message(
      text: "test text",
      date: DateTime.now().subtract(Duration(days: 2, minutes: 15)),
      sentByMe: true,
    ),
  ].reversed.toList();

  // Add a TextEditingController
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Customer Service",
              style: TextStyle(fontSize: 25),
            ),
            Icon(Icons.videocam_outlined, size: 25),
            Icon(Icons.phone_rounded, size: 25),
            Icon(Icons.more_vert, size: 25),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              order: GroupedListOrder.DESC, // Sorted from newest to oldest
              useStickyGroupSeparators: true,
              floatingHeader: true,
              reverse: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 45,
                child: Center(
                  child: Card(
                    // color: Theme.of(context).primaryColor,
                    color: Color(0xFF0d9488),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) =>
                Align(
                alignment: message.sentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    // elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    constraints: BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: message.sentByMe ? Color(0xFF0d9488) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        bottomRight: message.sentByMe ? Radius.circular(0) : Radius.circular(16),
                        bottomLeft: message.sentByMe ? Radius.circular(16) : Radius.circular(0),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(2, 2)),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                          color: message.sentByMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // send message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Container(
              // color: Colors.grey[200],
              decoration: BoxDecoration(
                color: Color(0xFFF5F2EA),
                borderRadius: BorderRadius.circular(30),
              ),
              // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          // borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Message",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.image),
                        ),
                      ),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          final message = Message(
                            text: text,
                            date: DateTime.now(),
                            sentByMe: true,
                          );
                          setState(() {
                            messages.add(message);
                          });
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final text = _controller.text;
                      if (text.isNotEmpty) {
                        final message = Message(
                          text: text,
                          date: DateTime.now(),
                          sentByMe: true,
                        );
                        setState(() {
                          messages.add(message);
                        });
                        _controller.clear();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0d9488)),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

