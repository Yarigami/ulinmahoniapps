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
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = "";

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

    String selected = "General";
    bool _expanded = false;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // title: TextButton(onPressed: (){},
          //     child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          // title: Text("My Booking"),
          backgroundColor: Color(0xFFd2c8ae),
          foregroundColor: Colors.white,
          bottom: PreferredSize(// USE TO SEPERATE THE TEXTBUTTON
            preferredSize: Size.fromHeight(60),//SIZE STARTING FROM THE END OF THE TEXTBUTTON HEIGHT
            child: Column(
              children: [
                Container(height: 28,
                color: Colors.white,),
                // SizedBox(height: 16,),
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Color(0xFFF5F2EA),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24))
                    ),
                    // indicatorColor: Colors.black,
                    labelColor: Color(0xFF0d9488),
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(child: SizedBox(width: 300, child: Center(child: Text("FAQ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)))),
                      Tab(child: SizedBox(width: 300, child: Center(child: Text("Contact Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5F2EA), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _faq(),
              _help(),
              // _contact(),
            ],
          ),
        ),
      );
    }

    Widget _faq(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _options("General"),
                  _options("Account"),
                  _options("Payment"),
                  _options("Services"),
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
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                      onPressed: (){
                        _searchController.clear();
                        setState(() {
                          _searchQuery = "";
                        });
                      },
                      icon: Icon(Icons.clear),
                  ) : null,
                ),
                onChanged: (value){
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
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
                color: Color(0xFF0d9488),
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

    Widget _options(String option,){
      final isSelected = option == selected;
      return TextButton(
        onPressed: (){
          setState(() {
            selected = option;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF0d9488) : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 4,
          shadowColor: Colors.black
        ),
        child: Text(option),
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
            color: Color(0xFF0d9488),
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
      final List<Map<String, String>> faqs = [
        {
          'option' : "",
          'questions': "Question 1",
          'answers': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies."
        },
        {
          'option' : "",
          'questions': "Question 2",
          'answers': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies."
        },
        {
          'option' : "",
          'questions': "this is question 3",
          'answers': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies."
        },
        {
          'option' : "",
          'questions': "General",
          'answers': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed arcu suscipit, consectetur massa non, imperdiet dolor. Donec efficitur erat vel felis euismod aliquam. Nam iaculis malesuada diam a ultricies.",
        },
        {
          'option' : "account",
          'questions': "Account",
          'answers': "Information answer",
        },
        {
          'option' : "payment",
          'questions': "Payment",
          'answers': "payment answer",
        },
        {
          'option' : "service",
          'questions': "Service",
          'answers': "service answer",
        },
      ];

      final filtered = faqs.where((faq) {
        final question = faq['questions']?.toLowerCase() ?? '';
        final answer = faq['answers']?.toLowerCase() ?? '';
        final option = faq['option']?. toLowerCase() ?? '';
        final categoryMatch = selected.toLowerCase() == 'general' ||
            (selected.toLowerCase() == 'account' && option.contains('account')) ||
            (selected.toLowerCase() == 'payment' && option.contains('payment')) ||
            (selected.toLowerCase() == 'services' && option.contains('service'));

        final searchMatch = _searchQuery.isEmpty ||
            question.contains(_searchQuery) ||
            answer.contains(_searchQuery);

        return categoryMatch && searchMatch;
      }).toList();

      return ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index){
          final faq = filtered[index];
          return _faqCard(questions: faq['questions']!, answers: faq['answers']!);
        },
        // children: filtered.map((faq) => _faqCard(
        //   questions: faq['question']!,
        //   answers: faq['answer']!,
        // )).toList()
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
