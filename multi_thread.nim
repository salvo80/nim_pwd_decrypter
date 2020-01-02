import nimSHA2
import times
import os,threadpool, strutils


var chan: Channel[string]
var esito: Channel[string]
let time = cpuTime()

proc worker(test:string)=
  var line = chan.recv()
  while line != "*_fine_*" and computeSHA256(line).hex != test:
    #echo getThreadId(),line," ",computeSHA256(line).hex
    line = chan.recv()
  esito.send(line)
  echo getThreadId(),"trovato ",line," in ",(cpuTime()-time)
 
proc find_pwd*(otest:string, pwd_file:string)=
  let test = toUpper(otest)
  chan.open(1000)
  esito.open()
  spawn worker(test)
  spawn worker(test)
  spawn worker(test)
  spawn worker(test)
  for line in lines pwd_file:
    chan.send(line)
  chan.send("*_fine_*")
  chan.send("*_fine_*")
  chan.send("*_fine_*")
  chan.send("*_fine_*")
  for i in 1..4:
    echo esito.recv()

  chan.close()
  echo "end"

