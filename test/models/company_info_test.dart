import 'package:cherry/models/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CompanyInfo', () {
    test('is correctly generated from a JSON', () {
      expect(
        CompanyInfo.fromJson(const {
          'headquarters': {
            'address': 'Rocket Road',
            'city': 'Hawthorne',
            'state': 'California'
          },
          'links': {
            'website': 'https://www.spacex.com/',
            'flickr': 'https://www.flickr.com/photos/spacex/',
            'twitter': 'https://twitter.com/SpaceX',
            'elon_twitter': 'https://twitter.com/elonmusk'
          },
          'name': 'SpaceX',
          'founder': 'Elon Musk',
          'founded': 2002,
          'employees': 8000,
          'vehicles': 3,
          'launch_sites': 3,
          'test_sites': 1,
          'ceo': 'Elon Musk',
          'cto': 'Elon Musk',
          'coo': 'Gwynne Shotwell',
          'cto_propulsion': 'Tom Mueller',
          'valuation': 52000000000,
          'summary':
              'SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.',
          'id': '5eb75edc42fea42237d7f3ed'
        }),
        CompanyInfo(
          city: 'Hawthorne',
          state: 'California',
          fullName: 'Space Exploration Technologies Corporation',
          name: 'SpaceX',
          founder: 'Elon Musk',
          founded: 2002,
          employees: 8000,
          ceo: 'Elon Musk',
          cto: 'Elon Musk',
          coo: 'Gwynne Shotwell',
          valuation: 52000000000,
          details:
              'SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.',
          id: '5eb75edc42fea42237d7f3ed',
        ),
      );
    });
  });
}
