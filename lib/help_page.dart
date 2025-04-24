import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cs_page.dart';

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
          child: Column(
            children: [
              Container(height: 8,
              color: Colors.white,),
              // SizedBox(height: 16,),
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24))
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
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _faq(),
          _help(),
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
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade600),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("General"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade600),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Account"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade600),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Payment"),
                ),
                TextButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade600),
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
          Expanded(child: _faqData()),
        ],
      ),
    );
  }

  Widget _helpCard({
    required IconData icons,
    required String name,
    bool cs = false,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          // padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              // margin: EdgeInsets.all(16.0),
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: (){
                  if (cs == true){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustSupport()));
                  }
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(icons, color: Colors.white, size: 25,),
                      SizedBox(width: 16.0),
                      Text(name, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _faqCard({
    required String questions,
    required String answers,
}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: GestureDetector(
        onTap: (){
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Card(
          color: Colors.green[800],
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Text(questions,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(answers,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _faqData(){
    return ListView(
      children: [
        _faqCard(
            questions: "Question 1",
            answers: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies."
        ),
        _faqCard(
            questions: "Question 2",
            answers: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies."
        ),
      ],
    );
  }

  Widget _help(){
    return ListView(
      children: [
        _helpCard(
          icons: Icons.headphones_outlined,
          name: "Customer Services",
          cs: true,
        ),
        _helpCard(
            icons: Icons.phone_rounded,
            name: "WhatsApp",
        ),
        _helpCard(
          icons: Icons.language,
          name: "Website",
        ),
        _helpCard(
          icons: Icons.facebook,
          name: "Facebook",
        ),
        _helpCard(
          icons: FontAwesomeIcons.twitter,
          name: "Twitter",
        ),
        _helpCard(
          icons: FontAwesomeIcons.instagram,
          name: "Instagram",
        ),
      ],
    );
  }
}
