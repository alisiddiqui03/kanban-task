import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kanban/views/completed_view.dart';
import 'package:kanban/views/inprogress_view.dart';
import 'package:kanban/views/pending_view.dart';

class AppTabbarView extends StatefulWidget {
  const AppTabbarView({Key? key});

  @override
  State<AppTabbarView> createState() => _AppTabbarViewState();
}

class _AppTabbarViewState extends State<AppTabbarView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.orange, // Background color of the tab bar
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: const BoxDecoration(
                  color: Colors.transparent, // No indicator color
                ),
                controller: tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  PendingView(),
                  InProgressView(),
                  CompletedView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
