enum CurrencyLocale {
  indonesia('IDR', 'Rp', 'id_ID', 'Indonesia'),
  singapore('SGD', '\$', 'en_SG', 'Singapore'),
  malaysia('MYR', 'RM', 'ms_MY', 'Malaysia'),
  thailand('THB', '฿', 'th_TH', 'ประเทศไทย'), // Prathet Thai (Thailand)
  vietnam('VND', '₫', 'vi_VN', 'Việt Nam'), // Vietnam
  philippines('PHP', '₱', 'en_PH', 'Philippines'),
  brunei('BND', '\$', 'ms_BN', 'Brunei Darussalam'),

  // Negara Besar Asia
  china('CNY', '¥', 'zh_CN', '中国'), // Zhongguo (China)
  japan('JPY', '¥', 'ja_JP', '日本'), // Nihon (Japan)
  southKorea('KRW', '₩', 'ko_KR', '대한민국'), // Daehan Minguk (Korea Selatan)
  india('INR', '₹', 'hi_IN', 'भारत'), // Bharat (India)
  hongKong('HKD', '\$', 'zh_HK', '香港'), // Xianggang (Hong Kong)

  // Negara Besar Eropa
  europeanUnion('EUR', '€', 'de_DE', 'Europäische Union'),
  unitedKingdom('GBP', '£', 'en_GB', 'United Kingdom'),
  russia('RUB', '₽', 'ru_RU', 'Россия'), // Rossiya (Russia)

  // Amerika Serikat
  unitedStates('USD', '\$', 'en_US', 'United States');

  final String code;
  final String symbol;
  final String idLocale;
  final String countryName;

  const CurrencyLocale(this.code, this.symbol, this.idLocale, this.countryName);
}

extension ListGetter on CurrencyLocale {
  List<String> get listOfCountryName {
    return CurrencyLocale.values.map((e) => e.countryName).toList();
  }

  List<String> get listOfCountryAndCurrencyCode {
    return CurrencyLocale.values.map((e) => '${e.countryName} (${e.code})').toList();
  }
}