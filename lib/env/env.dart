const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {'baseUrl': 'https://api.ustain.be/'};
const productionConfig = {'baseUrl': 'https://api.ustain.be/'};

final environment = isProduction ? productionConfig : devConfig;
