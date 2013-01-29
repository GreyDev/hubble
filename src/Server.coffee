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

			if not req.body.id?
				resp.json(400, {result: 'error', message: 'An item ID must be supplied with the request'})
				return

			if value? and (poll_url? or poll_seconds? or poll_failed?)
				resp.json(400, {result: 'error', message: 'It is not possible to both set a value manually and have it poll.'})
				return

			board.set parameters

			resp.json(200, {result: 'success', parameters: parameters})

		app.listen(config.server.port)
