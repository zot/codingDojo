###
Copyright (C) 2013, Bill Burdick

(licensed with ZLIB license)

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software. If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.

2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.

3. This notice may not be removed or altered from any source distribution.
###

lists = -> window.Lists

window.module = {}

window.Lists = {}

window.require = (name)-> modules[name]()

window.process =
  exit: ->
  stdout:
    write: (s)-> console.log s

modules =
  './lodash.min': -> window._
  './lists': lists
  './base': lists
  './testing': ->
    console.log "Accessing ./testing"
    rt = window.Lists.runTests
    window.Lists.runTests = (tests)->
      rt tests
      displayResults()
    window.Lists
  './testLists': lists

displayResults = ->
  window.setTimeout (->
    results = document.getElementById 'results'
    if results
      stats = window.Lists.stats
      if stats.failures
        results.classList.remove 'succeeded'
        results.classList.add 'failed'
        if stats.successes
          results.innerHTML = "Succeeded: <b>#{stats.successes}</b><br>Failed: <b>#{stats.failures}"
        else
          results.innerHTML = "Succeeded: <b>None</b><br>Failed: <b>#{stats.failures}"
        showTraces()
      else
        results.classList.add 'succeeded'
        results.classList.remove 'failed'
        if stats.failures
          results.innerHTML = "Succeeded: <b>#{stats.successes}</b><br>Failed: <b>#{stats.failures}"
        else
          results.innerHTML = "Succeeded: <b>#{stats.successes}</b><br>Failed: <b>None</b>"), 1

showTraces = ->
  stats = window.Lists.stats
  traceDiv = document.getElementById 'traces'
  traceDiv.innerHTML = ''
  for trace in stats.traces
    traceDiv.innerHTML += "<div>#{trace}</div><br>"
