import 'package:faker/faker.dart';

class FakeData {
  final String name;
  final String lastname;
  final String email;

  const FakeData({
    required this.name,
    required this.lastname,
    required this.email,
  });

  @override
  String toString() {
    return 'Name: $name\nLastname: $lastname\nEmail: $email\n';
  }
}

class FakePersonService {
  final Faker _faker = Faker();

  List<FakeData> generateFakePeople(int count) {
    return List.generate(count, (_) {
      return FakeData(
        name: _faker.person.name(),
        lastname: _faker.person.lastName(),
        email: _faker.internet.email(),
      );
    });
  }
}
