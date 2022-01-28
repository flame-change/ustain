const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {'baseUrl': 'http://127.0.0.1:8000/'};
const productionConfig = {'baseUrl': 'http://127.0.0.1:8000/'};

final environment = isProduction ? productionConfig : devConfig;
