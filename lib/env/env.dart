const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {'baseUrl': 'http://localhost:8000/'};
const productionConfig = {'baseUrl': 'http://localhost:8000/'};

final environment = isProduction ? productionConfig : devConfig;
