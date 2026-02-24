import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<Map<String, dynamic>> notifications = [
    {
      "title": "Chat Started",
      "message": "Your chat session has started.",
      "time": "2 min ago",
      "type": "chat",
      "isRead": false,
    },
    {
      "title": "Call Completed",
      "message": "₹200 deducted for 8 min call.",
      "time": "1 hour ago",
      "type": "call",
      "isRead": false,
    },
    {
      "title": "Special Offer 🎉",
      "message": "Get 20% extra talktime on recharge.",
      "time": "Yesterday",
      "type": "offer",
      "isRead": true,
    },
  ];

  int get unreadCount =>
      notifications.where((n) => n["isRead"] == false).length;

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  IconData getIcon(String type) {
    switch (type) {
      case "chat":
        return Icons.chat_bubble_outline;
      case "call":
        return Icons.call_outlined;
      case "offer":
        return Icons.local_offer_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  Color getIconColor(String type) {
    switch (type) {
      case "chat":
        return Colors.blue;
      case "call":
        return Colors.orange;
      case "offer":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title:   Text(
          "Notifications",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        actions: [

          /// 🔥 Notification Count Badge
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications, color: Colors.black),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style:   GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),

      body: notifications.isEmpty
          ? const EmptyState()
          : RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          itemBuilder: (context, index) {

            final notification = notifications[index];

            return Dismissible(
              key: Key(notification["title"] + index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.delete,
                    color: Colors.white),
              ),
              onDismissed: (_) {
                setState(() {
                  notifications.removeAt(index);
                });
              },
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    notifications[index]["isRead"] = true;
                  });
                },
                child: Container(
                  margin:
                  const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: notification["isRead"]
                        ? Colors.white
                        : const Color(0xFFFFF3E0),
                    borderRadius:
                    BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.03),
                        blurRadius: 8,
                        offset:
                        const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      Container(
                        padding:
                        const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: getIconColor(
                              notification["type"])
                              .withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getIcon(
                              notification["type"]),
                          color: getIconColor(
                              notification["type"]),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification["title"],
                              style:   GoogleFonts.montserrat(
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notification["message"],
                              style:   GoogleFonts.montserrat(
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notification["time"],
                              style:   GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color:
                                  Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      if (!notification["isRead"])
                        const Icon(Icons.circle,
                            size: 10,
                            color: Colors.orange),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// 🔥 EMPTY STATE UI
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [
          Icon(Icons.notifications_off,
              size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No Notifications Yet",
            style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "You're all caught up 🎉",
            style: GoogleFonts.montserrat(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}