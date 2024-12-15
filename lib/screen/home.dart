import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:checkmate/const/colors.dart';
import 'package:checkmate/screen/add_note_screen.dart';
import 'package:checkmate/widgets/stream_note.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: show ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: show ? 1 : 0,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
            },
            backgroundColor: customGreen,
            icon: Icon(Icons.add, size: 24),
            label: Text('Add Note'),
            elevation: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() => show = true);
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() => show = false);
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'My Notes',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stream_note(false),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stream_note(true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
