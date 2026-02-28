import 'dart:async';
import 'package:get/get.dart';

class MessageModel {
  String text;
  bool isMe;
  bool isRead;

  MessageModel({
    required this.text,
    required this.isMe,
    this.isRead = false,
  });
}

class ChatController extends GetxController {
  var coins = 50.obs;
  var seconds = 0.obs;
  var isTyping = false.obs;

  var messages = <MessageModel>[].obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();

    messages.add(
      MessageModel(
        text: "Namaste 🙏 Kaise madad kar sakta hoon?",
        isMe: false,
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;

      if (seconds.value % 60 == 0) {
        coins.value -= 5;

        if (coins.value <= 0) {
          timer.cancel();
          Get.snackbar("Balance Low", "Chat Ended");
          Get.back();
        }
      }
    });
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(MessageModel(text: text, isMe: true));
    simulateReadStatus();
    simulateReply();
  }

  void simulateReadStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    messages.last.isRead = true;
    messages.refresh();
  }

  void simulateReply() async {
    isTyping.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isTyping.value = false;

    messages.add(
      MessageModel(
        text: "Aapki kundli check kar raha hoon 🔮",
        isMe: false,
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}