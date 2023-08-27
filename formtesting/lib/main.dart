import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final _formkey = GlobalKey<FormState>();


trysubmit()
{
  final isvalid = _formkey.currentState!.validate();
  if(isvalid)
    {
      _formkey.currentState!.save();
      submit();
    }
}

submit()
{
  print(name);
}


String name = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: Center(
        child: Form(
          key: _formkey,
              child: Column(
            children: [
              TextFormField(
            key: ValueKey('name'),
            validator: (value){
              if(value.toString().isEmpty)
                {
                  return 'write name';
                }
              else
                {
                  return null;
                }
            },
                onSaved: (value){
              name = value.toString();
                },
        ),
              TextButton(onPressed: (){
                  trysubmit();
              }, child: Text("submit"))
          ],
        ),
        ),
      )
    );
  }
}
