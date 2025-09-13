class BaseResp {
  final String statusMessage;
  final int statusCode;
  final Map<String, String>? extra;

  BaseResp({required this.statusMessage, required this.statusCode, this.extra});

  factory BaseResp.fromJson(Map<String, dynamic> json) {
    return BaseResp(
      statusMessage: json['StatusMessage'],
      statusCode: json['StatusCode'],
      extra:
          json['Extra'] != null
              ? Map<String, String>.from(json['Extra'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StatusMessage': statusMessage,
      'StatusCode': statusCode,
      'Extra': extra,
    };
  }
}
