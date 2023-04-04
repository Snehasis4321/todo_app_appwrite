import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_appwrite/auth.dart';
import 'package:todo_app_appwrite/controllers/todo_provider.dart';
import 'package:todo_app_appwrite/shared.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Welcome"),
                accountEmail: Text("${UserSavedData.getEmail}")),
            ListTile(
              onTap: () {
                todoProvider.deleteAllTodos().then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("All Todos Deleted")));
                });
              },
              title: Text("Delete All Todos"),
              leading: Icon(Icons.delete_forever),
            ),
            ListTile(
              onTap: () {
                logoutUser().then(
                    (value) => Navigator.pushReplacementNamed(context, '/'));
              },
              title: Text("Logout"),
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? showOngoingTodos() : showCompletedTodos(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
                _selectedIndex = value;
              }),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todo List"),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed")
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget showOngoingTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        print(provider.allTodos.length);
        print(provider.getCompletedLength());
        return provider.checkLoading
            ? Center(child: CircularProgressIndicator())
            : provider.allTodos.length - provider.getCompletedLength() == 0
                ? Center(child: Text("No Todos"))
                : ListView.builder(
                    itemCount: provider.allTodos.length,
                    itemBuilder: (context, index) {
                      return provider.allTodos[index].data['isDone'] == true
                          ? SizedBox()
                          : ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/edit',
                                    arguments: provider.allTodos[index]);
                              },
                              title: Text(
                                provider.allTodos[index].data['title'],
                              ),
                              subtitle: Text(
                                provider.allTodos[index].data['description'],
                              ),
                              leading: Checkbox(
                                value:
                                    provider.allTodos[index].data['isDone'] ??
                                        false,
                                onChanged: (value) {
                                  provider.markCompleted(
                                      provider.allTodos[index].$id,
                                      !provider.allTodos[index].data['isDone']);
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  provider
                                      .deleteTodo(provider.allTodos[index].$id);
                                },
                              ),
                            );
                    },
                  );
      },
    );
  }

  Widget showCompletedTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        return provider.checkLoading
            ? Center(child: CircularProgressIndicator())
            : provider.getCompletedLength() == 0
                ? Center(child: Text("No Todos Completed"))
                : ListView.builder(
                    itemCount: provider.allTodos.length,
                    itemBuilder: (context, index) {
                      return provider.allTodos[index].data['isDone'] != true
                          ? SizedBox()
                          : ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/edit',
                                    arguments: provider.allTodos[index]);
                              },
                              title: Text(
                                provider.allTodos[index].data['title'],
                              ),
                              subtitle: Text(
                                provider.allTodos[index].data['description'],
                              ),
                              leading: Checkbox(
                                value:
                                    provider.allTodos[index].data['isDone'] ??
                                        false,
                                onChanged: (value) {
                                  provider.markCompleted(
                                      provider.allTodos[index].$id,
                                      !provider.allTodos[index].data['isDone']);
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  provider
                                      .deleteTodo(provider.allTodos[index].$id);
                                },
                              ),
                            );
                    },
                  );
      },
    );
  }
}
