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
  final bool SentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.SentByMe,
  });
}

class _CustSupportState extends State<CustSupport> {
  List<Message> messages = [
    Message(
      text: "test text 2",
      date: DateTime.now().subtract(Duration(days: 2, minutes: 10)),
      SentByMe: false,
    ),
    Message(
      text: "test text",
      date: DateTime.now().subtract(Duration(days: 2, minutes: 5)),
      SentByMe: true,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Theme.of(context).primaryColor,
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
              itemBuilder: (context, Message message) => Align(
                alignment: message.SentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: "Message",
              ),
              onSubmitted: (text) {
                final message = Message(
                  text: text,
                  date: DateTime.now(),
                  SentByMe: true,
                );
                setState(() {
                  messages.add(message);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}