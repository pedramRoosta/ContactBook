import 'package:contact_app/classed.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      routes: {'new_contact': (context) => const NewContact()},
      home: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact App')),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (ctx, list, widget) {
          final contacts = list as List<Contact>;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  ContactBook().remove(contact: contacts[index]);
                },
                key: ValueKey(contacts[index].id),
                child: Material(
                  color: Colors.white,
                  elevation: 0.4,
                  child: ListTile(
                    title: Text(contacts[index].name),
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('new_contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewContact extends StatefulWidget {
  const NewContact({Key? key}) : super(key: key);

  @override
  State<NewContact> createState() => NewContactState();
}

class NewContactState extends State<NewContact> {
  late final TextEditingController nameCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: 'Enter a new contact name here...',
              ),
            ),
            TextButton(
              onPressed: () {
                final contact = Contact(name: nameCtrl.text);
                ContactBook().add(contact: contact);
                Navigator.of(context).pop();
              },
              child: const Text('Add contact'),
            ),
          ],
        ),
      ),
    );
  }
}
