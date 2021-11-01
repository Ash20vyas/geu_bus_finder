import 'dart:convert';

var busData = [
  {
    'reg_num': 'UK07PA 2334',
    'bus': 3,
    'start time': '7.10 AM',
    'driver': 8006136454,
    'stops': [
      'Kulhal I, Dehradun, India',
      'Harbatpur Chowk, Dehradun, India',
      'Langa Road, Dehradun, India',
      'Shaspur, Dehradun, India',
      'Selaqui, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasan Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07DF 6969',
    'bus': 400,
    'start time': '7.10 AM',
    'driver': 9149117784,
    'stops': [
      'Kulhal I, Dehradun, India',
      'Harbatpur Chowk, Dehradun, India',
      'Langa Road, Dehradun, India',
      'Shaspur, Dehradun, India',
      'Selaqui, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasan Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07DF 6969',
    'bus': 69,
    'start time': '7.10 AM',
    'driver': 9347994899,
    'stops': [
      'Kulhal I, Dehradun, India',
      'Harbatpur Chowk, Dehradun, India',
      'Langa Road, Dehradun, India',
      'Shaspur, Dehradun, India',
      'Selaqui, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasan Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA2623',
    'bus': 34,
    'start time': '7.35 AM',
    'driver': 7078198090,
    'stops': [
      'Selaqui Chowk, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasant Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 4119',
    'bus': 51,
    'start time': '7.10 AM',
    'driver': 9456707877,
    'stops': [
      'Bahuwala Raja Road, Dehradun, India',
      'Raja Road, Dehradun, India',
      'Bansiwala, Dehradun, India',
      'Manduwala, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Prem Nagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      ', Dehradun, India',
      'Balliwalachowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'GEU, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3816',
    'bus': 46,
    'start time': '8.00 AM',
    'driver': 9759767817,
    'stops': [
      'Naya Gaon Palio, Dehradun, India',
      ', Dehradun, India',
      'Badowala, Dehradun, India',
      'Telpur, Dehradun, India',
      'Mehuwala, Dehradun, India',
      'ISBT, Dehradun, India',
      ', Dehradun, India'
    ]
  },
  {
    'reg_num': 'UA07Q4731',
    'bus': 22,
    'start time': '8.00 AM',
    'driver': 9897158551,
    'stops': [
      'Badowala, Dehradun, India',
      ', Dehradun, India',
      'Telpur, Dehradun, India',
      'Mehuwala, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 2191',
    'bus': 6,
    'start time': '7.30 AM',
    'driver': 8439113766,
    'stops': [
      'Ranipokhri, Dehradun, India',
      'Doiwala, Dehradun, India',
      'Lachiwala, Dehradun, India',
      'Kuanwala, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 2341',
    'bus': 5,
    'start time': '7.35 AM',
    'driver': 7088320038,
    'stops': [
      'Doiwala tachiwala, Dehradun, India',
      'Kuanwala, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1811',
    'bus': 14,
    'start time': '7.35 AM',
    'driver': 9720653064,
    'stops': [
      'Doiwala Lachiwala, Dehradun, India',
      'Kuanwala, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07 PA 1791',
    'bus': 27,
    'start time': '7.35 AM',
    'driver': 9634500480,
    'stops': [
      'Doiwala Lachiwala, Dehradun, India',
      'Kuanwala, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 4117',
    'bus': 49,
    'start time': '7.35 AM',
    'driver': 9634625829,
    'stops': [
      'Doiwala Lachiwala, Dehradun, India',
      'Kuanwala, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwa Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 4160',
    'bus': 53,
    'start time': '8.00 AM',
    'driver': 9837329322,
    'stops': [
      'Nakrounda More, Dehradun, India',
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 2621',
    'bus': 36,
    'start time': '8.00 AM',
    'driver': 906839224,
    'stops': [
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07 PA 3346',
    'bus': 39,
    'start time': '8.00 AM',
    'driver': 9997581218,
    'stops': [
      'Harawala, Dehradun, India',
      'Miawala, Dehradun, India',
      'Mokampur, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3815',
    'bus': 45,
    'start time': '8.10 AM',
    'driver': 8126419824,
    'stops': [
      'Mokampur Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1266',
    'bus': 8,
    'start time': '8.00 AM',
    'driver': 7464924796,
    'stops': [
      'Bangali Kothi, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1944',
    'bus': 15,
    'start time': '8.00 AM',
    'driver': 9760185881,
    'stops': [
      'Race Course, Dehradun, India',
      ', Dehradun, India',
      'Dharampur, Dehradun, India',
      'Mata Mandir, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 1695',
    'bus': 12,
    'start time': '8.15 AM',
    'driver': 9897576124,
    'stops': [
      'Dharampur, Dehradun, India',
      'Mata Mandir, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 2190',
    'bus': 20,
    'start time': '8.00 AM',
    'driver': 8958342280,
    'stops': [
      'Supply, Dehradun, India',
      'Garhi Cantt, Dehradun, India',
      'ONGC Chowk, Dehradun, India',
      'Ballupur Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1910',
    'bus': 21,
    'start time': '8.00 AM',
    'driver': 9997810167,
    'stops': [
      'Supply, Dehradun, India',
      'Garhi Cantt, Dehradun, India',
      'ONGC Chowk, Dehradun, India',
      'Ballupur Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3344',
    'bus': 38,
    'start time': '8.00 AM',
    'driver': 9897210157,
    'stops': [
      'Hathibadkala, Dehradun, India',
      'Garhi Cant, Dehradun, India',
      'ONGO Chowk, Dehradun, India',
      'Ballupur Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3814',
    'bus': 44,
    'start time': '8.00 AM',
    'driver': 8126496527,
    'stops': [
      'Rajender Nagar, Dehradun, India',
      'Yamuna Coloney, Dehradun, India',
      'Binda Pul, Dehradun, India',
      'Kishan Nagar, Dehradun, India',
      'Blood Bank, Dehradun, India',
      'Ballupur Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3848',
    'bus': 47,
    'start time': '7.10 AM',
    'driver': 9758277447,
    'stops': [
      'VikasNagar YATRIK HOTEL, Dehradun, India',
      'Tehsil, Dehradun, India',
      'Harbatpur Chowk, Dehradun, India',
      'Langa Road, Dehradun, India',
      'Shaspur, Dehradun, India',
      'Selaqui, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasant Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3348',
    'bus': 37,
    'start time': '7.35 AM',
    'driver': 7830755686,
    'stops': [
      'Selaqui Chowk, Dehradun, India',
      'Sudhowala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasant Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 1688',
    'bus': 1,
    'start time': '8.00 AM',
    'driver': 7302690682,
    'stops': [
      'Bansiwala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasant Vihar, Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 2192',
    'bus': 4,
    'start time': '8.00 AM',
    'driver': 6396224083,
    'stops': [
      'Bansiwala, Dehradun, India',
      'Nanda Ki Chowki, Dehradun, India',
      'Premnagar, Dehradun, India',
      'Panditwari, Dehradun, India',
      'Vasant Vihar, Dehradun, India',
      ', Dehradun, India',
      'Baliwala Chowk, Dehradun, India',
      'GMS Road, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 4172',
    'bus': 56,
    'start time': '8.00 AM',
    'driver': 9997455824,
    'stops': [
      'Badowala Telpur, Dehradun, India',
      'Mehuwala, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07PA 3542',
    'bus': 42,
    'start time': '8.00 AM',
    'driver': 9410105794,
    'stops': [
      'Asley Hall, Dehradun, India',
      'Clock Tower, Dehradun, India',
      ', Dehradun, India',
      'Darshanlal Chowk, Dehradun, India',
      'Saharanpur Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 1696',
    'bus': 18,
    'start time': '8.00 AM',
    'driver': 9557782210,
    'stops': [
      'Clock Tower, Dehradun, India',
      'Darshanlal Chowk, Dehradun, India',
      'Saharanpur Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07PA 1693',
    'bus': 26,
    'start time': '8.00 AM',
    'driver': 7252081695,
    'stops': [
      'Saharanpur Chowk, Dehradun, India',
      'Matawala Bagh, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1691',
    'bus': 24,
    'start time': '8.00 AM',
    'driver': 8958990677,
    'stops': [
      'Matawala Bagh, Dehradun, India',
      'Sabji Mandi, Dehradun, India',
      'Majra, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 4171',
    'bus': 55,
    'start time': '8.00 AM',
    'driver': 9760821022,
    'stops': [
      'Rajpur, Dehradun, India',
      'Krishna Chowk, Dehradun, India',
      'Jakhan, Dehradun, India',
      'Dilaram Bazar, Dehradun, India',
      'Nanni Bakery, Dehradun, India',
      'Survey Chowk, Dehradun, India',
      'Dwarka Store, Dehradun, India',
      'Araghar, Dehradun, India',
      'Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 3546',
    'bus': 43,
    'start time': '8.00 AM',
    'driver': 7252025697,
    'stops': [
      'Great Value, Dehradun, India',
      'Dilaram Bazar, Dehradun, India',
      'Nanni Bakery, Dehradun, India',
      'Survey Chowk, Dehradun, India',
      'Dwarka Store, Dehradun, India',
      'Araghar, Dehradun, India',
      'Rispana, Dehradun, India',
      'Kargi, Dehradun, India',
      'Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3345',
    'bus': 40,
    'start time': '8.00 AM',
    'driver': 8979731306,
    'stops': [
      'Raipur, Dehradun, India',
      'Gujuraunwala, Dehradun, India',
      'Ranjawala Raipur, Dehradun, India',
      '6 No. Pulia, Dehradun, India',
      'Ring Road, Dehradun, India',
      'Fountain Chowk, Dehradun, India',
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu/Gehu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 4121',
    'bus': 52,
    'start time': '8.00 AM',
    'driver': 6399150551,
    'stops': [
      'Raipur, Dehradun, India',
      'Raipur Chowk, Dehradun, India',
      'Dobhal Chowk, Dehradun, India',
      '6 No. Pulia, Dehradun, India',
      'Ring Road, Dehradun, India',
      'Post Office Nehru Gram, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Rispana, Dehradun, India',
      ', Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu/Gehu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 1690',
    'bus': 10,
    'start time': '8.00 AM',
    'driver': 9758902014,
    'stops': [
      'Raipur, Dehradun, India',
      'Raipur Chowk, Dehradun, India',
      'Nehru Gram, Dehradun, India',
      'Jogiwala, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA0630',
    'bus': 23,
    'start time': '8.00 AM',
    'driver': 8077857327,
    'stops': [
      '6 No. Pulia, Dehradun, India',
      'Fountain Chowk Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 3546',
    'bus': 41,
    'start time': '8.00 AM',
    'driver': 7535907988,
    'stops': [
      'Post Office Nehru Gram, Dehradun, India',
      '6 No. Pulia, Dehradun, India',
      'Ring Road, Dehradun, India',
      'Fountain Chowk, Dehradun, India',
      'Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu/Gehu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA2622',
    'bus': 35,
    'start time': '8.00 AM',
    'driver': 7895572900,
    'stops': [
      'Fountain Chowk, Dehradun, India',
      'Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK07PA 4118',
    'bus': 50,
    'start time': '8.00 AM',
    'driver': 8938963328,
    'stops': [
      'Kali Mandir, Dehradun, India',
      ', Dehradun, India',
      'Ladpur, Dehradun, India',
      '6 No. Pulia, Dehradun, India',
      'Fountain Chowk Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 4161',
    'bus': 54,
    'start time': '8.00 AM',
    'driver': 9897999048,
    'stops': [
      'IT Park, Dehradun, India',
      'Nala Paani Chowk, Dehradun, India',
      'Shastdhara Crossing, Dehradun, India',
      'Ladpur, Dehradun, India',
      '6, Dehradun, India',
      'No. Pulia, Dehradun, India',
      ', Dehradun, India',
      ', Dehradun, India',
      'Fountain Chowk Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 1698',
    'bus': 19,
    'start time': '8.00 AM',
    'driver': 9149159227,
    'stops': [
      'IT Park, Dehradun, India',
      'Nala Paani Chowk, Dehradun, India',
      'Shastdhara Crossing, Dehradun, India',
      'Ladpur, Dehradun, India',
      '6 No. Pulia, Dehradun, India',
      'Fountain Chowk Rispana, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      ', Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 3849',
    'bus': 48,
    'start time': '8.00 AM',
    'driver': 9557902542,
    'stops': [
      'Rispana, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu/Gehu, Dehradun, India'
    ]
  },
  {
    'reg_num': 'UK 07 PA 0858',
    'bus': 13,
    'start time': '8.00 AM',
    'driver': 9897983344,
    'stops': [
      'ludwala, Dehradun, India',
      'Mathurawala, Dehradun, India',
      'Vishnupuram, Dehradun, India',
      'Bangali Kothi, Dehradun, India',
      'Kargi Chowk, Dehradun, India',
      'ISBT, Dehradun, India',
      'Geu, Dehradun, India'
    ]
  }
];
var locations = [
  {
    'stop': 'badowala, dehradun, india',
    'loc': [30.301056199999998, 77.9524488]
  },
  {
    'stop': 'supply, dehradun, india',
    'loc': [30.3699278, 78.05876]
  },
  {
    'stop': 'sudhowala, dehradun, india',
    'loc': [30.3450839, 77.9361588]
  },
  {
    'stop': 'fountain chowk rispana, dehradun, india',
    'loc': [30.3021495, 78.0562906]
  },
  {
    'stop': 'mathurawala, dehradun, india',
    'loc': [30.2617154, 78.03380779999999]
  },
  {
    'stop': 'no. pulia, dehradun, india',
    'loc': [30.3161365, 78.0412953]
  },
  {
    'stop': 'gms road, dehradun, india',
    'loc': [30.310004999999997, 78.0078262]
  },
  {
    'stop': 'bansiwala, dehradun, india',
    'loc': [30.3448035, 77.9038897]
  },
  {
    'stop': 'geu/gehu, dehradun, india',
    'loc': [30.268570699999998, 77.994788]
  },
  {
    'stop': 'manduwala, dehradun, india',
    'loc': [30.3880099, 77.94102509999999]
  },
  {
    'stop': 'survey chowk, dehradun, india',
    'loc': [30.325606800000003, 78.05271139999999]
  },
  {
    'stop': 'ongc chowk, dehradun, india',
    'loc': [30.3420268, 78.0163954]
  },
  {
    'stop': 'baliwala chowk, dehradun, india',
    'loc': [30.323914499999997, 78.0113332]
  },
  {
    'stop': 'nanda ki chowki, dehradun, india',
    'loc': [30.344562099999997, 77.9545906]
  },
  {
    'stop': 'binda pul, dehradun, india',
    'loc': [30.3265808, 78.03378909999999]
  },
  {
    'stop': 'doiwala lachiwala, dehradun, india',
    'loc': [30.175877099999997, 78.1242422]
  },
  {
    'stop': 'jogiwa rispana, dehradun, india',
    'loc': [30.294481, 78.058002]
  },
  {
    'stop': 'vasant vihar, dehradun, india',
    'loc': [30.3226277, 78.0036994]
  },
  {
    'stop': 'garhi cant, dehradun, india',
    'loc': [30.3579473, 78.042782]
  },
  {
    'stop': 'kishan nagar, dehradun, india',
    'loc': [30.333479800000003, 78.02657239999999]
  },
  {
    'stop': 'rajpur, dehradun, india',
    'loc': [30.384723899999997, 78.089439]
  },
  {
    'stop': 'lachiwala, dehradun, india',
    'loc': [30.223021199999998, 78.07660360000001]
  },
  {
    'stop': 'dobhal chowk, dehradun, india',
    'loc': [30.298339499999997, 78.08052570000001]
  },
  {
    'stop': 'fountain chowk, dehradun, india',
    'loc': [30.3023836, 78.0565041]
  },
  {
    'stop': 'nehru gram, dehradun, india',
    'loc': [30.288390799999995, 78.0902682]
  },
  {
    'stop': 'dharampur, dehradun, india',
    'loc': [30.2990951, 78.05705379999999]
  },
  {
    'stop': 'majra, dehradun, india',
    'loc': [30.296555199999997, 77.99659609999999]
  },
  {
    'stop': 'jogiwala rispana, dehradun, india',
    'loc': [30.2857815, 78.0684311]
  },
  {
    'stop': 'kuanwala, dehradun, india',
    'loc': [30.2395901, 78.1022729]
  },
  {
    'stop': 'miawala, dehradun, india',
    'loc': [30.266966399999998, 78.0908651]
  },
  {
    'stop': 'mata mandir, dehradun, india',
    'loc': [30.297272399999997, 78.0426763]
  },
  {
    'stop': 'ranjawala raipur, dehradun, india',
    'loc': [30.296063300000004, 78.0990301]
  },
  {
    'stop': 'nakrounda more, dehradun, india',
    'loc': [30.2334115, 78.1279359]
  },
  {
    'stop': 'rispana, dehradun, india',
    'loc': [30.295049900000002, 78.0567731]
  },
  {
    'stop': 'yamuna coloney, dehradun, india',
    'loc': [30.328462499999997, 78.02596009999999]
  },
  {
    'stop': 'ludwala, dehradun, india',
    'loc': [30.316494499999997, 78.03219179999999]
  },
  {
    'stop': 'sabji mandi, dehradun, india',
    'loc': [30.3197752, 78.0344058]
  },
  {
    'stop': 'premnagar, dehradun, india',
    'loc': [30.334042, 77.9601775]
  },
  {
    'stop': 'race course, dehradun, india',
    'loc': [30.313619199999998, 78.0461199]
  },
  {
    'stop': 'raipur chowk, dehradun, india',
    'loc': [30.290114400000004, 78.09548319999999]
  },
  {
    'stop': 'balliwalachowk, dehradun, india',
    'loc': [30.323914499999997, 78.0113332]
  },
  {
    'stop': 'kargi chowk, dehradun, india',
    'loc': [30.2908871, 78.0247115]
  },
  {
    'stop': 'araghar, dehradun, india',
    'loc': [30.306879700000003, 78.0498583]
  },
  {
    'stop': 'jogiwala, dehradun, india',
    'loc': [30.2857815, 78.0684311]
  },
  {
    'stop': 'kargi, dehradun, india',
    'loc': [30.284944999999997, 78.02381969999999]
  },
  {
    'stop': 'ranipokhri, dehradun, india',
    'loc': [30.1812198, 78.21058570000001]
  },
  {
    'stop': 'great value, dehradun, india',
    'loc': [30.363830999999998, 78.06953399999999]
  },
  {
    'stop': 'vishnupuram, dehradun, india',
    'loc': [30.300314200000003, 78.0649062]
  },
  {
    'stop': 'kulhal i, dehradun, india',
    'loc': [30.3790676, 78.1051246]
  },
  {
    'stop': 'prem nagar, dehradun, india',
    'loc': [30.334042, 77.9601775]
  },
  {
    'stop': 'vikasnagar yatrik hotel, dehradun, india',
    'loc': [30.472096999999998, 77.77802799999999]
  },
  {
    'stop': 'tehsil, dehradun, india',
    'loc': [30.32188, 78.0409238]
  },
  {
    'stop': 'mokampur, dehradun, india',
    'loc': [30.2788086, 78.0786543]
  },
  {
    'stop': 'matawala bagh, dehradun, india',
    'loc': [30.3154173, 78.0231062]
  },
  {
    'stop': 'ring road, dehradun, india',
    'loc': [30.301704200000003, 78.0749383]
  },
  {
    'stop': 'ballupur chowk, dehradun, india',
    'loc': [30.333144699999995, 78.0113332]
  },
  {
    'stop': 'raja road, dehradun, india',
    'loc': [30.317426599999997, 78.0359818]
  },
  {
    'stop': 'garhi cantt, dehradun, india',
    'loc': [30.3579473, 78.042782]
  },
  {
    'stop': 'nanni bakery, dehradun, india',
    'loc': [30.3320508, 78.0537872]
  },
  {
    'stop': 'nala paani chowk, dehradun, india',
    'loc': [30.315010699999995, 78.05843709999999]
  },
  {
    'stop': 'ladpur, dehradun, india',
    'loc': [30.315511199999996, 78.07802989999999]
  },
  {
    'stop': 'mokampur jogiwala, dehradun, india',
    'loc': [30.2857815, 78.0684311]
  },
  {
    'stop': 'hathibadkala, dehradun, india',
    'loc': [30.347986499999998, 78.05225399999999]
  },
  {
    'stop': 'panditwari, dehradun, india',
    'loc': [30.330090599999995, 77.9881334]
  },
  {
    'stop': 'langa road, dehradun, india',
    'loc': [30.4213642, 77.8055309]
  },
  {
    'stop': 'jakhan, dehradun, india',
    'loc': [30.3634028, 78.06634509999999]
  },
  {
    'stop': 'gujuraunwala, dehradun, india',
    'loc': [30.316494499999997, 78.03219179999999]
  },
  {
    'stop': 'mehuwala, dehradun, india',
    'loc': [30.298254900000003, 77.9681544]
  },
  {
    'stop': 'doiwala, dehradun, india',
    'loc': [30.175877099999997, 78.1242422]
  },
  {
    'stop': 'raipur, dehradun, india',
    'loc': [30.308999000000004, 78.0948064]
  },
  {
    'stop': 'blood bank, dehradun, india',
    'loc': [30.3342243, 78.0176667]
  },
  {
    'stop': 'doiwala tachiwala, dehradun, india',
    'loc': [30.175877099999997, 78.1242422]
  },
  {
    'stop': 'it park, dehradun, india',
    'loc': [30.3654494, 78.0799138]
  },
  {
    'stop': 'harbatpur chowk, dehradun, india',
    'loc': [30.438286299999998, 77.7366242]
  },
  {
    'stop': 'krishna chowk, dehradun, india',
    'loc': [30.333479800000003, 78.02657239999999]
  },
  {
    'stop': 'ongo chowk, dehradun, india',
    'loc': [30.3364771, 78.05446289999999]
  },
  {
    'stop': 'darshanlal chowk, dehradun, india',
    'loc': [30.322943199999994, 78.0430817]
  },
  {
    'stop': 'saharanpur chowk, dehradun, india',
    'loc': [30.3174931, 78.0282788]
  },
  {
    'stop': 'dilaram bazar, dehradun, india',
    'loc': [30.336253499999998, 78.05540479999999]
  },
  {
    'stop': 'clock tower, dehradun, india',
    'loc': [30.3252639, 78.0412983]
  },
  {
    'stop': 'rajender nagar, dehradun, india',
    'loc': [30.339558900000004, 78.0231062]
  },
  {
    'stop': 'telpur, dehradun, india',
    'loc': [30.3114524, 77.980289]
  },
  {
    'stop': 'harawala, dehradun, india',
    'loc': [30.322357699999994, 78.040585]
  },
  {
    'stop': 'asley hall, dehradun, india',
    'loc': [30.327694, 78.04647]
  },
  {
    'stop': 'bahuwala raja road, dehradun, india',
    'loc': [30.397229900000003, 77.918174]
  },
  {
    'stop': 'selaqui chowk, dehradun, india',
    'loc': [30.368133300000004, 77.8566199]
  },
  {
    'stop': 'isbt, dehradun, india',
    'loc': [30.289188699999997, 77.9986668]
  },
  {
    'stop': 'chowk, dehradun, india',
    'loc': [30.325606800000003, 78.05271139999999]
  },
  {
    'stop': 'post office nehru gram, dehradun, india',
    'loc': [30.292488199999998, 78.0723798]
  },
  {
    'stop': 'vasan vihar, dehradun, india',
    'loc': [30.3226277, 78.0036994]
  },
  {
    'stop': 'shaspur, dehradun, india',
    'loc': [30.392712399999994, 77.8095661]
  },
  {
    'stop': 'shastdhara crossing, dehradun, india',
    'loc': [30.354931699999998, 78.0833181]
  },
  {
    'stop': '6 no. pulia, dehradun, india',
    'loc': [30.316494499999997, 78.03219179999999]
  },
  {
    'stop': 'badowala telpur, dehradun, india',
    'loc': [30.301056199999998, 77.9524488]
  },
  {
    'stop': 'naya gaon palio, dehradun, india',
    'loc': [30.363450999999994, 78.0584851]
  },
  {
    'stop': 'kali mandir, dehradun, india',
    'loc': [30.321460000000002, 78.07434479999999]
  },
  {
    'stop': 'dwarka store, dehradun, india',
    'loc': [30.3157339, 78.04982749999999]
  },
  {
    'stop': 'bangali kothi, dehradun, india',
    'loc': [30.285024200000002, 78.039678]
  },
  {
    'stop': 'selaqui, dehradun, india',
    'loc': [30.368158500000003, 77.86531260000001]
  }
];
