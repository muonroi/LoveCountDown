import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InnerFolder extends StatefulWidget {
  const InnerFolder({super.key, required this.filespath});
  final String filespath;

  @override
  State<StatefulWidget> createState() {
    return InnerFolderState();
  }
}

class InnerFolderState extends State<InnerFolder> {
  String get fileStr => widget.filespath;

  final folderController = TextEditingController();
  late String nameOfFolder;

  File? _image;
  List<File> _imageFiles = [];
  Future<void> _getImageFromGallery() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _saveImageToFolder();
        _loadImagesFromFolder();
      });
    }
  }

  Future<void> _saveImageToFolder() async {
    final imagePath = '$fileStr/${DateTime.now().millisecondsSinceEpoch}.png';
    await _image?.copy(imagePath);
  }

  Future<void> _loadImagesFromFolder() async {
    final imagesDirectory = Directory(fileStr);
    final files = await imagesDirectory.list().toList();
    final imageFiles = files
        .where((file) => file is File && file.path.endsWith('.png'))
        .map((file) => file as File)
        .toList();
    setState(() {
      _imageFiles = imageFiles;
    });
  }

  Future<void> _deleteImage(int index) async {
    await _imageFiles[index].delete();
    setState(() {
      _imageFiles.removeAt(index);
      _loadImagesFromFolder();
    });
  }

  Future<void> _showFullScreenImage(File imageFile) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: GestureDetector(
              child: Center(
                child: Image.file(imageFile),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _loadImagesFromFolder();
    super.initState();
  }

  Widget _buildImageWidget(File imageFile, int index) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(imageFile),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Xoá ảnh nà'),
            content: const Text('Mún xoá hemmmm hỏ hỏ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('hemmmmmm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  _deleteImage(index);
                },
                child: const Text('Xoá dùm ikkkkkk'),
              ),
            ],
          ),
        );
      },
      child: Stack(
        children: [
          Image.file(imageFile),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteImage(index),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nội dung thư mục"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        actions: [
          IconButton(
              onPressed: () {
                _getImageFromGallery();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _imageFiles.isEmpty
          ? const Center(child: Text('Hẻm coá hình choyyyy'))
          : ListView.builder(
              itemCount: _imageFiles.length,
              itemBuilder: (context, index) {
                return _buildImageWidget(_imageFiles[index], index);
              },
            ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }
}
