import 'package:flutter/material.dart';


class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: TextButton(onPressed: (){},
        //     child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        // title: Text("My Booking"),
        backgroundColor: Colors.green.shade700,
        bottom: PreferredSize(// USE TO SEPERATE THE TEXTBUTTON
          preferredSize: Size.fromHeight(48),//SIZE STARTING FROM THE END OF THE TEXTBUTTON HEIGHT
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.green[500],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              // indicatorColor: Colors.black,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(child: SizedBox(width: 300, child: Center(child: Text("FAQ")))),
                Tab(child: SizedBox(width: 300, child: Center(child: Text("Contact Us"),),),),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _faq(),
          Text("contact"),
          // _contact(),
        ],
      ),
    );
  }

  Widget _faq(){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("General"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Account"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Payment"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Services"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 32.0),
            // padding: const EdgeInsets.all(32.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search for help",
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Card(
                child: AnimatedCrossFade(
                  firstChild: Container(
                    width: 400,
                    height: 50,
                    padding: EdgeInsets.all(12.0),
                    // alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Main Text"),
                      ],
                    ),
                  ),
                  secondChild: Container(
                    width: 400,
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Main Text"),
                        SizedBox(height: 8),
                        Text("Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext "),
                      ],
                    ),
                  ),
                  crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
