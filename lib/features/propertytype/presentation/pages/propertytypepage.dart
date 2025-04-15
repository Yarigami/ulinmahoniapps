import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/propertytype_data.dart';
import '../widgets/propertyitem.dart';

class PropertyTypePage extends StatefulWidget {
  const PropertyTypePage({super.key});

  @override
  State<PropertyTypePage> createState() => _PropertyTypePageState();
}

class _PropertyTypePageState extends State<PropertyTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildPropertyTypeList(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1E7D39),
      title: const Text('Property Types', style: TextStyle(color: Colors.white)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
    );
  }

  Widget _buildPropertyTypeList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return PropertyItem(
          title: category['title']!,
          image: category['image']!,
          onTap: () {
            final route = category['route'] ?? '/comingsoon';
            context.push(route);
          },
        );
      },
    );
  }
}
