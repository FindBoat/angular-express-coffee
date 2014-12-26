var moduleName = process.env.npm_config_module
var commandName = process.env.npm_config_command

try {
  var commandModule = require('./.app/manage/' + moduleName);
} catch(e) {
  console.warn('Module not found: ' + moduleName, e);
  return;
}

if (typeof(commandModule[commandName]) == 'function') {
  var actionMethod = commandModule[commandName].bind(commandModule);
  actionMethod();
} else {
  console.warn('Method not found: ' + commandName);
}
