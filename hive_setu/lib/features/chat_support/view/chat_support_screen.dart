import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});
  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _messages = <_Message>[
    _Message(text: 'नमस्ते! मैं Hive Setu सहायक हूँ। आपकी क्या मदद कर सकता हूँ?', isBot: true, time: '10:00'),
    _Message(text: 'मेरी Hive-3 में Varroa mite की समस्या है।', isBot: false, time: '10:01'),
    _Message(text: 'Varroa mite के लिए Oxalic Acid vaporization सबसे अच्छा इलाज है। ब्रूडलेस अवधि में Apivar strip भी लगा सकते हैं।', isBot: true, time: '10:01'),
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: text, isBot: false, time: '10:02'));
      _messages.add(_Message(text: 'समझ गया। हम आपकी मदद करेंगे। कृपया एक विशेषज्ञ से संपर्क करें।', isBot: true, time: '10:02'));
    });
    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Chat Support', subtitle: 'सहायता केंद्र'),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scroll,
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              itemCount: _messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, i) => _ChatBubble(message: _messages[i]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: AppColors.ambientShadow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'अपना सवाल लिखें...',
                      hintStyle: AppTextStyles.inputHint.copyWith(color: AppColors.onSurfaceVariant),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(
                      gradient: AppColors.pollenPillGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: AppColors.white, size: 20),
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

class _Message {
  const _Message({required this.text, required this.isBot, required this.time});
  final String text, time;
  final bool isBot;
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});
  final _Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            Container(
              width: 32, height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.amberGradient),
              child: const Center(child: Text('🐝', style: TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: message.isBot ? AppColors.surface : AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isBot ? 4 : 16),
                  bottomRight: Radius.circular(message.isBot ? 16 : 4),
                ),
                boxShadow: message.isBot ? AppColors.ambientShadow : null,
              ),
              child: Column(
                crossAxisAlignment: message.isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(message.text, style: AppTextStyles.bodySmall.copyWith(color: message.isBot ? AppColors.onSurface : AppColors.white)),
                  const SizedBox(height: 4),
                  Text(message.time, style: AppTextStyles.caption.copyWith(color: message.isBot ? AppColors.onSurfaceVariant : AppColors.white.withValues(alpha: 0.7))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
