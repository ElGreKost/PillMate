import 'package:flutter/material.dart';
import 'package:pillmate/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pillmate/services/personal_data.dart';
import 'package:provider/provider.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Widget> _messages = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lovedOneNameController = TextEditingController();
  final TextEditingController _lovedOnePhoneController =
      TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _lovedOneNameController.dispose();
    _lovedOnePhoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _introducePillMate();
    });
  }

  void _introducePillMate() {
    _addMessage(
        TextBubble(
            message:
                "Hello and welcome to PillMate! I'm here to make sure you don't forget your medication.",
            isPillMate: true),
        true);
    _addMessage(
        TextBubble(
            message: "Together we are going to take care of your health. To do this, help me set up your unique profile by answering 3 questions.\n"
                "Please given simple, one-word answers.",
            isPillMate: true),
        true);
    _askForName();
  }

  void _addMessage(Widget message, bool isPillMate) {
    setState(() {
      _messages.add(message);
    });
    if (isPillMate) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {});
      });
    }
  }

  void _addUserMessage(String message) {
    // Remove the editable text bubble before adding the new message
    setState(() {
      if (_messages.last is TextBubble &&
          (_messages.last as TextBubble).textController != null) {
        _messages.removeLast();
      }
      _messages.add(TextBubble(message: message, isPillMate: false));
    });
  }

  void _askForName() {
    _addMessage(
      TextBubble(message: "May I have your name, please?", isPillMate: true),
      true,
    );
    _addEditableMessage(_nameController, (value) {
      if(RegExp(r'^\S+$').hasMatch(value)) {
        Provider.of<UserDataProvider>(context, listen:false).updateName(value);
        _handleUserInput(value, "My name is ", _askForLovedOneName);
      }
    });
  }

  void _askForLovedOneName() {
    _addMessage(
      TextBubble(
          message:
              "Who is a loved one we can contact in case you forget your medication?",
          isPillMate: true),
      true,
    );
    _addEditableMessage(_lovedOneNameController, (value) {
      if(RegExp(r'^\S+$').hasMatch(value)) {
        Provider.of<UserDataProvider>(context, listen:false).updateLovedName(value);
        _handleUserInput(value, "My loved one's name is ", _askForLovedOnePhone);
      }
    });
  }

  void _askForLovedOnePhone () async  {
    _addMessage(
      TextBubble(message: "What's their phone number?", isPillMate: true),
      true,
    );
    _addEditableMessage(_lovedOnePhoneController, (value) async {
      if(RegExp(r'^\S+$').hasMatch(value)) {
        final userDataProvider = Provider.of<UserDataProvider>(context, listen:false);
        userDataProvider.updatePhoneNumber(value);
        await userDataProvider.addData();
        _handleUserInput(value, "Their phone number is ", _goToMainApplication);
      }
    });
  }


  void _goToMainApplication() {
    _addMessage(
      TextBubble(
          message: "All set! Now, let's head over to the main application.",
          isPillMate: true),
      true,
    );
    setState(() {
      _messages.add(
        Center(
          child: ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isFirstVisit', false);
              Navigator.pushNamed(context, AppRoutes.homescreenPage);
            },
            child: Text('Go to Main Application'),
          ),
        ),
      );
    });
  }

  void _addEditableMessage(
      TextEditingController controller, Function(String) onSubmitted) {
    setState(() {
      _messages.add(
        TextBubble(
          textController: controller,
          onSubmitted: onSubmitted,
        ),
      );
    });
  }

  void _handleUserInput(String value, String prefix, VoidCallback onContinue) {
    setState(() {
      _messages.removeLast(); // Remove the TextField
      _messages.add(TextBubble(message: prefix + value, isPillMate: false));
    });
    onContinue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PillMate Onboarding"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _messages.length,
        itemBuilder: (context, index) => _messages[index],
      ),
    );
  }
}

class TextBubble extends StatelessWidget {
  final String? message;
  final bool isPillMate;
  final TextEditingController? textController;
  final Function(String)? onSubmitted;

  const TextBubble({
    Key? key,
    this.message,
    this.isPillMate = false,
    this.textController,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPillMate || message != null) {
      final alignment =
          isPillMate ? CrossAxisAlignment.start : CrossAxisAlignment.end;
      final color = isPillMate ? appTheme.grey300 : appTheme.cyan900;

      return Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(message ?? '',
                style: TextStyle(color: appTheme.whiteA700)),
          ),
          if (isPillMate)
            Padding(
              padding: EdgeInsets.only(left: 8, top: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/pillMate.png', width: 50),
              ),
            ),
        ],
      );
    } else {
      // When it's the user's turn to type a response
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: appTheme.cyan900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: textController,
              onSubmitted: onSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: "Type your one-word answer...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              style: TextStyle(color: appTheme.teal100),
              cursorColor: appTheme.cyan500,
            ),
          ),
        ],
      );
    }
  }
}
