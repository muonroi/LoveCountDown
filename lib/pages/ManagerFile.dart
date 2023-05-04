import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'detailfolder.dart';

void main() {
  runApp(const AppFile());
}

class AppFile extends StatelessWidget {
  const AppFile({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewFiles(),
    );
  }
}

class ViewFiles extends StatefulWidget {
  const ViewFiles({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ViewFiles> {
  Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/StoreGirlFriend/$folderName/');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }

  callFolderCreationMethod(String folderInAppDocDir) async {
    // ignore: unused_local_variable
    String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
    setState(() {});
  }

  final folderController = TextEditingController();
  late String nameOfFolder;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              Text(
                'Thêm thư mục',
                textAlign: TextAlign.left,
              ),
              Text(
                'Tên thư mục hình bé mún tạo ó',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: folderController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: 'Bé nhập tên dùm cái ikkkkkk'),
                onChanged: (val) {
                  setState(() {
                    nameOfFolder = folderController.text;
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Hẻm thêm',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Thêm lun',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await callFolderCreationMethod(nameOfFolder);
                getDir();
                setState(() {
                  folderController.clear();
                  nameOfFolder = "";
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  late List<FileSystemEntity> _folders;
  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final folderPath = '$dir/StoreGirlFriend';
    final myDir = Directory(folderPath);
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }
    setState(() {
      _folders = myDir
          .listSync(recursive: true, followLinks: false)
          .whereType<Directory>()
          .toList();
      ;
    });
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Bé coá mún xoá hemmmm?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('honggggggg'),
              onPressed: () async {
                await _folders[index].delete();
                getDir();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('hong'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<FileSystemEntity> _filterFolders(String query) {
    return _folders.where((folder) {
      return folder.path.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    _folders = [];
    getDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Quản lý hình ảnh"),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home_page');
            },
            icon: const Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Material(
            elevation: 6.0,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: getFileType(_folders[index]),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              FileStat f = snapshot.data as FileStat;
                              if (f.type.toString().contains("file")) {
                                return const Icon(
                                  Icons.file_copy_outlined,
                                  size: 100,
                                  color: Colors.orange,
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (builder) {
                                      return InnerFolder(
                                          filespath: _folders[index].path);
                                    }));
                                  },
                                  child: const Icon(
                                    Icons.folder,
                                    size: 100,
                                    color: Colors.orange,
                                  ),
                                );
                              }
                            }
                            return const Icon(
                              Icons.file_copy_outlined,
                              size: 100,
                              color: Colors.orange,
                            );
                          }),
                      Text(
                        _folders[index].path.split('/').last,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteDialog(index);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: _folders.length,
      ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }
}
