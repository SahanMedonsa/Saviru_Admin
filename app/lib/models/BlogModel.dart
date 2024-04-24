import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String Title;
  String Description;
  String Subtitle;
  Timestamp createdOn;
  Timestamp UpdatedOn;

  Blog(
      {required this.Title,
      required this.Description,
      required this.Subtitle,
      required this.createdOn,
      required this.UpdatedOn});

  Blog.fromJson(Map<String, Object?> json)
      : this(
          Title: json['Title']! as String? ?? '',
          Description: json['Description'] as String? ?? '',
          Subtitle: json['Subtitle'] as String? ?? '',
          createdOn: json['createdOn']! as Timestamp,
          UpdatedOn: json['UpdatedOn']! as Timestamp,
        );

  Blog copyWith({
    String? Title,
    String? Description,
    String? Subtitle,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? UpdatedOn,
  }) {
    return Blog(
        Title: Title ?? this.Title,
        Description: Description ?? this.Description,
        Subtitle: Subtitle ?? this.Subtitle,
        createdOn: createdOn ?? this.createdOn,
        UpdatedOn: UpdatedOn ?? this.UpdatedOn);
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': Title,
      'Description': Description,
      'Subtitle': Subtitle,
      'createdOn': createdOn,
      'UpdatedOn': UpdatedOn
    };
  }
}


//convert to jason