class TemplateModel {
  final String name;
  final String path;
  final String type;
  final String folder;
  final String suffixFile;
  final String suffixName;

  TemplateModel({
    required this.name,
    required this.path,
    required this.type,
    required this.folder,
    required this.suffixFile,
    required this.suffixName,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'path': path,
      'folder': folder,
      'suffix_file': suffixFile,
      'suffix_name': suffixName,
    };
  }

  // Create from Map
  factory TemplateModel.fromMap(Map<dynamic, dynamic> map) {
    return TemplateModel(
      name: map['name'] as String,
      type: map['type'] as String,
      path: map['path'] as String,
      folder: map['folder'] as String,
      suffixFile: map['suffix_file'] as String,
      suffixName: map['suffix_name'] as String,
    );
  }
}
