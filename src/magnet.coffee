# Description:
#   Get a torrent maget
#
# Commands:
#   hubot magnet|마그넷 <query>

module.exports = (robot) ->
  robot.respond /(magnet|마그넷) (.*)/i, (msg) ->
    torrentMe msg, msg.match[2], (url) ->
      msg.send url

torrentMe = (msg, query, cb) ->
  msg.http('https://torrentproject.se/')
    .query(s: query, out:'json')
    .get() (err, res, body) ->
      r = JSON.parse(body)[1]
      cb "*#{r.title}*\n`magnet:?xt=urn:btih:#{r.torrent_hash}`"
