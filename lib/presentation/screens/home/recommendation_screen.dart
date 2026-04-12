import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/theme/app_colors.dart';

/* ================= MODEL ================= */

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

/* ================= SCREEN ================= */

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [];
  bool isLoading = false;

  /* ================= THEME (Calendar-style) ================= */

  bool get isNight {
    final hour = DateTime.now().hour;
    return hour >= 18 || hour <= 6;
  }

  Color get bgColor =>
      isNight ? Colors.blueGrey.shade900 : Colors.orange.shade50;

  /* BOT (THEMED) */
  Color get botBubbleColor =>
      isNight ? Colors.blueGrey.shade800 : Colors.orange.shade100;

  Color get botTextColor =>
      isNight ? Colors.white : Colors.black87;

  /* USER (SIMPLE + CONSTANT LOOK) */
  Color get userBubbleColor =>
      isNight ? Colors.grey.shade700 : Colors.grey.shade300;

  Color get userTextColor =>
      isNight ? Colors.white : Colors.black87;

  /* INPUT */
  Color get inputBg =>
      isNight ? Colors.blueGrey.shade800 : Colors.white;

  Color get sendBg =>
      isNight ? Colors.blueGrey.shade600 : Colors.orange.shade400;

  /* ================= API ================= */

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text: text, isUser: true));
      isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse("https://your-backend.com/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": text}),
      );

      String reply = "No response";

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        reply = data["reply"] ?? "No reply";
      }

      setState(() {
        messages.add(ChatMessage(text: reply, isUser: false));
      });
    } catch (_) {
      setState(() {
        messages.add(
          ChatMessage(text: "Something went wrong", isUser: false),
        );
      });
    }

    setState(() => isLoading = false);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Chat"),
      ),

      body: Column(
        children: [
          /* ================= MESSAGES ================= */

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];

                final isUser = msg.isUser;

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isUser
                          ? userBubbleColor
                          : botBubbleColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: isUser
                            ? userTextColor
                            : botTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /* ================= TYPING ================= */

          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "typing...",
                style: TextStyle(
                  color: isNight
                      ? Colors.white54
                      : Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),

          /* ================= INPUT BAR ================= */

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              children: [
                /* INPUT FIELD */
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: inputBg,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isNight
                            ? Colors.white24
                            : Colors.black12,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: sendMessage,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /* SEND BUTTON */
                GestureDetector(
                  onTap: () => sendMessage(_controller.text),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: sendBg,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.15),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.send,
                      size: 20,
                      color: isNight
                          ? Colors.white
                          : Colors.black,
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