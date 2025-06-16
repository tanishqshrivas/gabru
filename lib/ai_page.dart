import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! Welcome to Sanjeevika App. I'm your AI health assistant.\nHow can I help you today?",
      isBot: true,
      time: "11:51 PM",
    ),
  ];

  void _sendMessage() {
    final input = _messageController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: input,
        isBot: false,
        time: _getCurrentTime(),
      ));
    });

    _messageController.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "Thanks for your message! I'm here to help with your health queries.",
          isBot: true,
          time: _getCurrentTime(),
        ));
      });
    });
  }

  Future<void> _pickImage() async {
    try {
      // Show dialog to choose between camera and gallery
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Image Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
              ],
            ),
          );
        },
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _messages.add(ChatMessage(
              text: "Image shared",
              isBot: false,
              time: _getCurrentTime(),
              imagePath: image.path,
            ));
          });

          // Simulate AI response to image
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _messages.add(ChatMessage(
                text: "I can see the image you've shared! How can I help you analyze or discuss this image?",
                isBot: true,
                time: _getCurrentTime(),
              ));
            });
          });
        }
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFFE2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C2C2C)),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -5,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.chat_bubble_outline_outlined, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Sanjeevika AI Chat Assistant',
                  style: TextStyle(
                    color: Color(0xFF003313),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '• Online',
                  style: TextStyle(
                    color: Color(0xFF4FB700),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),

          // Center logo image when only intro message is shown
          if (_messages.length <= 1)
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/logo_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

          // Message input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  _buildIconButton(
                    Icons.photo_library_outlined,
                    backgroundColor: const Color(0xFFBBF7D0),
                    borderColor: const Color(0xFF02A820),
                    iconColor: const Color(0xFF02A820),
                    onPressed: _pickImage,
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Color(0xFFBBF7D0), width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Type your message...',
                                hintStyle: TextStyle(color: Color(0xFF919191)),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          _buildIconButton(
                            Icons.mic_none,
                            size: 30,
                            borderColor: const Color(0xFFBBF7D0),
                            backgroundColor: Colors.white,
                            iconColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  _buildIconButton(
                    Icons.send_outlined,
                    backgroundColor: const Color(0xFFBBF7D0),
                    borderColor: const Color(0xFF02A820),
                    iconColor: const Color(0xFF02A820),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, {
        Color backgroundColor = const Color(0xFFE8F5E8),
        Color borderColor = Colors.transparent,
        Color iconColor = Colors.grey,
        double size = 25,
        void Function()? onPressed,
      }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: size),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isBot;
  final String time;
  final String? imagePath;

  ChatMessage({
    required this.text,
    required this.isBot,
    required this.time,
    this.imagePath,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
        message.isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (message.isBot)
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.chat_bubble_outline_outlined, color: Colors.white, size: 15),
                ),
                const SizedBox(width: 4),
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6F6F6F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: message.isBot ? Colors.white : const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display image if present
                          if (message.imagePath != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(message.imagePath!),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          // Display text
                          Text(
                            message.text,
                            style: TextStyle(
                              color: message.isBot ? Colors.black87 : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
