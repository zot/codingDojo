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

root = module.exports = require './base'
_ = require './lodash.min'

list = (args...)-> makeList 0, args

makeList = (index, elements)->
  if index < elements.length then cons elements[index], makeList index + 1, elements
  else Nil

cons = (a, b)-> addListProto (f)-> f a, b

addListProto = (l)->
  l.__proto__ = Cons.prototype
  l

first = (l)-> checkList l, -> l (a, b)-> a

rest = (l)-> checkList l, -> l (a, b)-> b

checkList = (l, cont)-> if l instanceof Cons then cont() else throw new Error "Not a list!"

# Using classes for type checking and for printing

class Cons
  toString: -> "List [#{@elements(false)}]"
  elements: (comma)-> "#{if comma then ', ' else ''}#{first(@)}#{rest(@).elements(true)}"

class NilClass
  toString: -> "List []"
  elements: (comma)-> ""

Nil = new NilClass

root.list = list
root.cons = cons
root.Nil = Nil
root.first = first
root.rest = rest
root.len = len
