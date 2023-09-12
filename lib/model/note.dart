const String tableNameNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, macAddress, ipAddress, title, description, time
  ];
  static const String id = '_id';
  static const String macAddress = 'macAddress';
  static const String ipAddress = 'ipAddress';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final String? macAddress;
  final String? ipAddress;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
     this.macAddress,
     this.ipAddress,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? macAddress,
    String? ipAddress,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        macAddress: macAddress ?? this.macAddress,
        ipAddress: ipAddress ?? this.ipAddress,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        macAddress: json[NoteFields.macAddress] as String,
        ipAddress: json[NoteFields.ipAddress] as String,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.macAddress: macAddress,
        NoteFields.ipAddress: ipAddress,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
