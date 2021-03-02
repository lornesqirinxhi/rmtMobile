class AdrLocation{
  String placeFormattedAddress;
  String placeName;
  String placeId;
  double latitude;
  double longitude;

  AdrLocation(
      {this.placeFormattedAddress,
      this.placeName,
      this.placeId,
      this.latitude,
      this.longitude});

  factory AdrLocation.fromMap(Map<String, dynamic> map) {
    return new AdrLocation(
      placeFormattedAddress: map['formatted_address'] as String,
      placeName: map['formatted_address'] as String,
      placeId: map['place_id'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'placeFormattedAddress': this.placeFormattedAddress,
      'placeName': this.placeName,
      'placeId': this.placeId,
      'latitude': this.latitude,
      'longitude': this.longitude,
    } as Map<String, dynamic>;
  }
}