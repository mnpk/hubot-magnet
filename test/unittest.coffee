path = require 'path'
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
chai = require 'chai'
blanket = require 'blanket'
{ expect } = chai


describe 'hubot', ->
  robot = null
  user = null
  adapter = null

  beforeEach (done)->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      process.env.HUBOT_AUTH_ADMIN = "1"
      robot.loadFile path.resolve('.', 'src'), 'magnet.coffee'
      user = robot.brain.userForId '1', {
        name: 'mocha',
        root: '#mocha'
      }
      adapter = robot.adapter
      do done
    do robot.run

  afterEach ->
    do robot.server.close
    do robot.shutdown

  describe 'magnet', ->
    this.timeout(5000)
    it 'should send a magnet result on command 마그넷', (done)->
      adapter.on 'send', (env, str)->
        result = "*뽀로로 5기*\n`magnet:?xt=urn:btih:2631adbf45677b4e7dce2d510e0e4c9c3fde8e55`"
        expect(str[0]).to.equal result
        do done
      adapter.receive new TextMessage user, 'hubot 마그넷 뽀로로'
    it 'should send a magnet result on command magnet', (done)->
      adapter.on 'send', (env, str)->
        result = "*뽀로로 5기*\n`magnet:?xt=urn:btih:2631adbf45677b4e7dce2d510e0e4c9c3fde8e55`"
        expect(str[0]).to.equal result
        do done
      adapter.receive new TextMessage user, 'hubot magnet 뽀로로'
    it 'should send a 404 result', (done)->
      adapter.on 'send', (env, str)->
        result = ":no_good: 404 Not Found"
        expect(str[0]).to.equal result
        do done
      adapter.receive new TextMessage user, 'hubot magnet invalidinvalidinvalid'
