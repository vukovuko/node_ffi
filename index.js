const myAddon = require('./build/addon.node');

const result = myAddon.Hello();
myAddon.InitRaylibWindow(1440, 900, 'Hello from Node.js', 'Hello from Node.js');

console.log(result);
