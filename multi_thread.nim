import nimSHA2
import times
import os,threadpool


var chan: Channel[string]
let time = cpuTime()

proc worker(test:string)=
  var line = chan.recv()
  while computeSHA256(line).hex!=test:
    #echo getThreadId(),line
    line = chan.recv()
    
  #if computeSHA256(line).hex==test:
  echo "trovato ",line
  echo "eseguito in ",(cpuTime()-time)
  chan.close()
   
proc find_pwd*(test:string, pwd_file:string)=
  chan.open(1000)
  
  spawn worker(test)
  spawn worker(test)
  spawn worker(test)
  spawn worker(test)
  
  for line in lines pwd_file:
    if chan.peek()<0:
      break
    chan.send(line)

  while chan.peek()>0:
    sleep(100)
  
  chan.close()


