import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/models/request/messaging/send_message.dart';
import 'package:jobhub/services/helpers/messaging_helper.dart';
import 'package:jobhub/views/ui/chat/widgets/message_textField.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../constants/app_constants.dart';
import '../../../controllers/chat_provider.dart';
import '../../../models/response/messaging/messaging_res.dart';
import '../../../services/config.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';
import '../search/searchpage.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({
    super.key,
    required this.title,
    required this.id,
    required this.profile,
    required this.user,
  });

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  int offset = 1;
  IO.Socket? socket;
  String receiver = "";
  late Future<List<ReceivedMessage>> msgList;
  List<ReceivedMessage> messages = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id, offset);
    // setState(() {});
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<<><><--loading--><><>>");
          if (messages.length >= 12) {
            getMessages(offset++);
            setState(() {});
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(Config.socketUrl, <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId); // Swap the arguments
    socket!.connect();
    socket!.onConnect((_) {
      print("connected to frontend");
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });
      socket!.on('typing', (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('message received', (newMessageReceived) {
        sendStopTyingEvent(widget.id);
        ReceivedMessage receivedMessage =
            ReceivedMessage.fromJson(newMessageReceived);

        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MessagingHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket!.emit('new message', emission);
      sendStopTyingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTyingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTyingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages(offset);
    connect();
    joinChat();
    handleNext();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(builder: (context, chatNotifier, child) {
      receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: !chatNotifier.typing ? widget.title : "typing .....",
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.profile),
                      backgroundColor: Color(kDark.value),
                    ),
                    Positioned(
                      right: 3,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: chatNotifier.online.contains(receiver)
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: GestureDetector(
                  onTap: () {
                    print("back icon pressed");
                    Get.to(()=> const MainScreen());
                  },
                  child: const Icon(
                    MaterialCommunityIcons.arrow_left,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<ReceivedMessage>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else if (snapshot.data!.isEmpty) {
                          return const SearchLoading(
                              text: "You do not have any messages");
                        } else {
                          final msgList = snapshot.data;
                          messages = messages + msgList!;
                          return ListView.builder(
                              controller: _scrollController,
                              reverse: true,
                              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final data = messages[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      ReusableText(
                                        text: chatNotifier.msgTime(
                                            data.chat.updatedAt.toString()),
                                        style: appstyle(
                                          16,
                                          Color(kDark.value),
                                          FontWeight.normal,
                                        ),
                                      ),
                                      const HeightSpacer(size: 15),
                                      ChatBubble(
                                        alignment: data.sender.id ==
                                                chatNotifier.userId
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        backGroundColor: data.sender.id ==
                                                chatNotifier.userId
                                            ? Color(kOrange.value)
                                            : Color(kLightBlue.value),
                                        elevation: 0,
                                        clipper: ChatBubbleClipper4(
                                            radius: 8,
                                            type: data.sender.id ==
                                                    chatNotifier.userId
                                                ? BubbleType.sendBubble
                                                : BubbleType.receiverBubble),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: width * 0.8,
                                          ),
                                          child: ReusableText(
                                            text: data.content,
                                            style: appstyle(
                                              14,
                                              Color(kLight.value),
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(12.h),
                  alignment: Alignment.bottomCenter,
                  child: MessagingTextField(
                    onSubmitted: (_){
                      sendMessage(
                          messageController.text, widget.id, receiver);
                    },
                    messageController: messageController,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        sendMessage(
                            messageController.text, widget.id, receiver);
                      },
                      child: Icon(
                        Icons.send,
                        size: 24,
                        color: Color(kLightBlue.value),
                      ),
                    ),
                    onTapOutside: (_) {
                      sendStopTyingEvent(widget.id);
                    },
                    onEditingComplete: () {
                      sendMessage(messageController.text, widget.id, receiver);
                    },
                    onChanged: (_) {
                      sendTyingEvent(widget.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
