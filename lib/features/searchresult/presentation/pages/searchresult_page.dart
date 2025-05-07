import 'package:flutter/material.dart';
import 'package:ulinmahoniapps/core/widgets/appbar.dart';
import '../../../../core/layout/mainlayout.dart';
import '../widgets/searchresult_grid.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 4,
      showBottomNav: false,
      showNavBar: false,
      showContactBar: true,
      pesansekarangbutton: false,
      child: const SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Search Result"),
            Expanded(child: SearchResultGrid()),
          ],
        ),
      ),
    );
  }
}
