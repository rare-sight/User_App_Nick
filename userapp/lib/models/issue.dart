class Issue {
  final int? id;
  final String service;
  final String category;
  final String description;
  final String images; // comma-separated paths
  final String status;

  Issue({
    this.id,
    required this.service,
    required this.category,
    required this.description,
    required this.images,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service': service,
      'category': category,
      'description': description,
      'images': images,
      'status': status,
    };
  }

  factory Issue.fromMap(Map<String, dynamic> map) {
    return Issue(
      id: map['id'],
      service: map['service'],
      category: map['category'],
      description: map['description'],
      images: map['images'],
      status: map['status'],
    );
  }
}
