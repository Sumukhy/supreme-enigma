import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.stitchAppId,
    this.stitchData,
    this.stitchProviderId,
    this.metaProviderId,
    this.metaAppId,
    this.metaData,
  });

  String? stitchAppId;
  Data? stitchData;
  String? stitchProviderId;
  String? metaProviderId;
  String? metaAppId;
  Data? metaData;

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) =>
      NotificationModel(
        stitchAppId: json["stitch.appId"],
        stitchData: Data.fromJson(jsonDecode(json["stitch.data"])),
        stitchProviderId: json["stitch.providerId"],
        metaProviderId: json["meta.provider_id"],
        metaAppId: json["meta.app_id"],
        metaData: Data.fromJson(jsonDecode(json["meta.data"])),
      );

  Map<dynamic, dynamic> toJson() => {
        "stitch.appId": stitchAppId,
        "stitch.data": stitchData!.toJson(),
        "stitch.providerId": stitchProviderId,
        "meta.provider_id": metaProviderId,
        "meta.app_id": metaAppId,
        "meta.data": metaData!.toJson(),
      };
}

class Data {
  Data({
    this.schemaVersion,
    this.typeId,
    this.save,
    this.id,
    this.type,
    this.timestamp,
    this.title,
    this.body,
    this.uid,
    this.content,
  });

  String? schemaVersion;
  String? typeId;
  String? save;
  String? id;
  String? type;
  String? timestamp;
  String? title;
  String? body;
  String? uid;
  String? content;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        schemaVersion: json["schema_version"],
        typeId: json["type_id"],
        save: json["save"],
        id: json["_id"],
        type: json["type"],
        timestamp: json["timestamp"],
        title: json["title"],
        body: json["body"],
        uid: json["uid"],
        content: json["content"],
      );

  Map<dynamic, dynamic> toJson() => {
        "schema_version": schemaVersion,
        "type_id": typeId,
        "save": save,
        "_id": id,
        "type": type,
        "timestamp": timestamp,
        "title": title,
        "body": body,
        "uid": uid,
        "content": content,
      };
}
