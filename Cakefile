fs            = require 'fs'
wrench        = require 'wrench'
{print}       = require 'util'
which         = require 'which'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

pkg = JSON.parse fs.readFileSync('./package.json')
testCmd = pkg.scripts.test
startCmd = pkg.scripts.start
  

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

build = (callback) ->
  # Compile coffee in src/server to .app directory
  options = ['-c','-b', '-o', '.app/server', 'src/server']
  cmd = which.sync 'coffee'
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

  # Compile coffee in src/manage to .app directory
  options = ['-c','-b', '-o', '.app/manage', 'src/manage']
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

  # Compile coffee in src/client/ to public/client/.
  options = ['-c','-b', '-o', 'public/client/', 'src/client/']
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> callback?() if status is 0

task 'build', ->
  build -> log ":)", green

task 'dev', 'start dev env', ->
  # watch_coffee
  options = ['-w', '-b', '-c', '-o', '.app/server', 'src/server']
  cmd = which.sync 'coffee'  
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr

  options = ['-w', '-b', '-c', '-o', '.app/manage', 'src/manage']
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr

  options = ['-w', '-c','-b', '-o', 'public/client/', 'src/client/']
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  
  log 'Watching coffee files', green
  # watch_js
  supervisor = spawn 'node', [
    './node_modules/supervisor/lib/cli-wrapper.js',
    '-w',
    '.app,public/client', 
    '-e', 
    'js|jade', 
    'server'
  ]
  supervisor.stdout.pipe process.stdout
  supervisor.stderr.pipe process.stderr
  log 'Watching js files and running server', green
