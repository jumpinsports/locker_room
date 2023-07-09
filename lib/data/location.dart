class Location {
  const Location({
    required this.code,
    required this.name,
    required this.address,
  });
  final String code;
  final String name;
  final String address;
}

List<Location> locations = [lsCommPark, tbd];

Location findLocation(String code) {
  for (Location location in locations) {
    if (location.code == code) {
      return location;
    }
  }
  return tbd;
}

Location lsCommPark = const Location(
  code: 'lscommpark',
  name: 'Lake Stevens Community Park',
  address: '1601 N Machias Rd\nLake Stevens, WA 98258',
);

Location tbd = const Location(
  code: 'tbd',
  name: 'TBD',
  address: '',
);
