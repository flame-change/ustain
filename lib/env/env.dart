const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {'baseUrl': 'https://dev-change.net/'};
const productionConfig = {'baseUrl': 'https://dev-change.net/'};

final environment = isProduction ? productionConfig : devConfig;