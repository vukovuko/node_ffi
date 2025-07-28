const myAddon = require('./addon.node');

const result = myAddon.Hello();
myAddon.InitRaylibWindow();

console.log(result);
