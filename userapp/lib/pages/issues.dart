import 'package:flutter/material.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage({super.key});

  @override
  State<IssuesPage> createState() => _IssuesPageState();

}
class _IssuesPageState extends State<IssuesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Issues Page'),
        centerTitle: true,
      ),backgroundColor: Colors.white,
      body: Center(
        
        child: Text(
          'This is the Issues Page',
          style: TextStyle(fontSize: 24,
          color: Colors.black)
            ,
        ),
      ),
    );
  }
}