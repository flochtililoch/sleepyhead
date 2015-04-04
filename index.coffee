request = require 'request'
zipObject = require 'lodash'
CSON = require 'cson'
debug = (require 'debug')('app')

{user, server} = CSON.load('./config.cson')

webhook = (data) ->
  {title, categories, mt_keywords, description} = data
  [method, url] = title.split(' ')

  url = "http:#{url}"
  headers = zipObject(categories, mt_keywords)
  json = JSON.parse(description)

  options = {method, url, headers, json}

  debug('Service invoked with following data:', options)
  request(options)

require('ifttt-wordpress-webhook')({user, server, webhook})
