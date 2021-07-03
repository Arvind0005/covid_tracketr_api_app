import 'dart:convert';

List<TotalResponse> totalResponseFromJson(String str) =>
    List<TotalResponse>.from(
        json.decode(str).map((x) => TotalResponse.fromJson(x)));

String totalResponseToJson(List<TotalResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalResponse {
  String confirmed;
  String recovered;
  String deaths;

  TotalResponse({
    this.confirmed,
    this.recovered,
    this.deaths,
  });

  factory TotalResponse.fromJson(Map<String, dynamic> json) => TotalResponse(
        confirmed: json["confirmed"],
        recovered: json["recovered"],
        deaths: json["deaths"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "recovered": recovered,
        "deaths": deaths,
      };
}
