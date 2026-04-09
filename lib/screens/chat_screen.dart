import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
        actions: [
          Switch(
            value: context.watch<ChatProvider>().useOpenAI,
            onChanged: (val) {
              context.read<ChatProvider>().toggleApi(val);
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, provider, __) {
                if (provider.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                          "https://assets10.lottiefiles.com/packages/lf20_jcikwtux.json",
                          width: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.forum_outlined,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Start a conversation...",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                _scrollToBottom();

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.messages.length,
                  itemBuilder: (_, i) {
                    final msg = provider.messages[i];
                    return MessageBubble(
                      text: msg['text'],
                      isUser: msg['role'] == 'user',
                      time: msg['time'],
                    );
                  },
                );
              },
            ),
          ),
          Consumer<ChatProvider>(
            builder: (_, provider, __) => provider.isTyping
                ? const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Typing..."),
            )
                : const SizedBox(),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Type message...",
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    context.read<ChatProvider>().sendMessage(_controller.text);
                    _controller.clear();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}