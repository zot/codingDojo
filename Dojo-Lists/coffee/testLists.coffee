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

###
Tests for lists
###

L = root = module.exports = require './lists'
require './testing'

{
  list,
  cons,
  Nil,
  first,
  rest,
  len,
  run,
  runTests,
  assertEq,
  assertFail,
  ifNoBrowser,
} = L

ifNoBrowser -> console.log 'Testing...'

runTests
  test1: -> assertEq "1", "1"
  test2: -> assertEq String(cons 1, Nil), "List [1]"
  test3: -> assertEq String(list 1, 2, 3), "List [1, 2, 3]"
  test4: -> assertFail (-> first Nil), "Not a list!"
  test5: -> assertFail (-> first 1), "Not a list!"
  test6: -> assertEq first(list 1, 2, 3), 1
  test7: -> assertEq first(rest list 1, 2, 3), 2

ifNoBrowser -> console.log '\nDone'
if !L.stats.failures then console.log "Succeeded all #{L.stats.successes} tests."
else console.log """
Succeeded #{L.stats.successes} test#{if L.stats.successes > 1 then 's' else ''}
Failed #{L.stats.failures} test#{if L.stats.failures > 1 then 's' else ''}:
"""
console.log "  #{f}" for f in L.stats.failed
process.exit(0)
