import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';

class UMpage extends StatefulWidget {
  const UMpage({super.key});

  @override
  State<UMpage> createState() => _UMpageState();
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

class _UMpageState extends State<UMpage> {
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
    return MainLayout(
      currentIndex: 2,
      showNavBar: false,
      showBottomNav: false,
      showContactBar: false,
      child: Column(
        children: [
          AppBar(
            backgroundColor: const Color(0xFF005F21),
            elevation: 1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Customer Service",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
                ),
                Icon(Icons.videocam_outlined, size: 20, color: Colors.white),
                Icon(Icons.phone_rounded, size: 20, color: Colors.white),
                Icon(Icons.more_vert, size: 20, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    order: GroupedListOrder.DESC,
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
                          color: const Color(0xFF124624),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                      alignment: message.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: message.sentByMe ? const Color(0xFF124624) : Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: const Radius.circular(16),
                              topLeft: const Radius.circular(16),
                              bottomRight: message.sentByMe ? Radius.zero : const Radius.circular(16),
                              bottomLeft: message.sentByMe ? const Radius.circular(16) : Radius.zero,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F2EA),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12),
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              hintText: "Message",
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.image),
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
                        const SizedBox(width: 8),
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
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF124624)),
                          ),
                          icon: const Icon(Icons.send, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
