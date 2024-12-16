import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkmate/const/colors.dart';

Widget buildStatisticsCard({
  required String title,
  required String count,
  required Color countColor,
}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 4),
      Text(
        count,
        style: TextStyle(
          color: countColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget buildStatsContainer({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

class NotesStatistics extends StatelessWidget {
  const NotesStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notes')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('Something went wrong')),
          );
        }

        if (!snapshot.hasData) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        int pendingCount = 0;
        int completedCount = 0;

        for (var doc in snapshot.data!.docs) {
          Map<String, dynamic> note = doc.data() as Map<String, dynamic>;
          if (note['isDon'] == true) {
            completedCount++;
          } else {
            pendingCount++;
          }
        }

        return SliverToBoxAdapter(
          child: buildStatsContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStatisticsCard(
                  title: 'Pending',
                  count: '$pendingCount',
                  countColor: Colors.black87,
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300],
                ),
                buildStatisticsCard(
                  title: 'Completed',
                  count: '$completedCount',
                  countColor: customGreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
