import nimSHA2
import times
import os
import lists
import threadpool, streams, strutils
{.experimental: "parallel".}

type
  Res = object
    word: string
    hex: string
    match: bool

proc removeAndReturn(extarr: DoublyLinkedList[string], s: string):string = 
  #var p:DoublyLinkedNode
  var arr = extarr
  var p = arr.find(s)
  arr.remove(p)
  return p.value

proc calcAll(extarr: DoublyLinkedList, test: string): string = 
  var arr = extarr
  for i in arr:
    if computeSHA256(removeAndReturn(arr, i)).hex == test:
      return test
  return ""

proc calc(s:string, test: string): bool = computeSHA256(s).hex == test

let test = paramStr(1)
echo test
var arr = initDoublyLinkedList[string]()
let time = cpuTime()
var count = 0

var strm = openFileStream("D:\\salvo\\Downloads\\rockyou.txt")
let f = strm.readAll().split('\n')
strm.close()
var res = newSeq[string]()
parallel:
  for line in f:
    let x = spawn calc(line,test)
    if x:
      res.add(line)

for i in res:
  echo i
#[
for line in lines "D:\\salvo\\Downloads\\rockyou.txt":
    if count > 999:
      let word = spawn calc(arr,test)
      if word != "":
        echo "trovato ",word
        break
      arr = initDoublyLinkedList[string]()
    arr.append(line)
    count = count + 1
  if arr.head != nil:
    let word = spawn calc(arr,test)
    if word != "":
      echo "trovato ",word
]#
echo "eseguito in ",(cpuTime()-time)

