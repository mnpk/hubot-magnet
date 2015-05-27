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
      r = JSON.parse(body)
      if r.total_found == "0"
        cb ":no_good: 404 Not Found"
      else
        r1 = r[1]
        cb "*#{r1.title}*\n`magnet:?xt=urn:btih:#{r1.torrent_hash}`"
