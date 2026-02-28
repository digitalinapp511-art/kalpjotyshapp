import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/chat_controller.dart';

class ChatUIScreen extends StatelessWidget {
  final String astrologerName;

  ChatUIScreen({super.key, required this.astrologerName});

  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),

      /// 🔝 AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Obx(
              () => AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.orange),
                ),
                const SizedBox(width: 10),

                /// Name + Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      astrologerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Online",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            /// 💰 Coins + Timer Section
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [

                    /// Coins Card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            controller.coins.value.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// Timer Card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            "${controller.seconds.value ~/ 60}:${(controller.seconds.value % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          /// 💬 Message List
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];

                  return Align(
                    alignment: msg.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      constraints: const BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        color: msg.isMe ? Colors.orange : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isMe ? Colors.white : Colors.black,
                            ),
                          ),

                          if (msg.isMe)
                            Icon(
                              msg.isRead ? Icons.done_all : Icons.done,
                              size: 16,
                              color: msg.isRead ? Colors.blue : Colors.white70,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// 🟢 Typing Animation
          Obx(() {
            if (controller.isTyping.value) {
              return const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Astrologer is typing...",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),

          /// ✍ Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.orange),
                  onPressed: () {
                    controller.sendMessage(textController.text);
                    textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
