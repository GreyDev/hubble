express = require 'express'
Board   = require './Board'

module.exports = class Server

	start: ->
		board = new Board

		app = express()
		app.use express.bodyParser()

		app.post '/', (req, resp) =>
			parameters =
				id:           req.body.id
				column:       req.body.column
				label:        req.body.label
				value:        req.body.value
				high:         req.body.high
				low:          req.body.low
				poll_url:     req.body.poll_url
				poll_seconds: req.body.poll_seconds
				poll_failed:  req.body.poll_failed
				poll_method:  req.body.poll_method

			if poll?
				resp.send 'You must supply an item ID!'
				return

			if value? and (poll_url? or poll_seconds? or poll_failed?)
				resp.send 'you cannot set the value manually and also have it poll. it needs to do one or the other'
				return

			board.set parameters

			resp.send 'OK'

		app.listen(config.server.port)
