import nimSHA2
import times
import os
import lists

proc calc(arr: DoublyLinkedList, test: string): string = 
  for i in arr:
    if computeSHA256(i).hex==test:
      return test
  return ""

let test = paramStr(1)
echo test
var arr = initDoublyLinkedList[string]()
let time = cpuTime()
for line in lines "D:\\salvo\\Downloads\\rockyou.txt":
  if arr.len > 999:
    parallel:
      if spawn calc(arr,test) != "":
        echo "trovato ",line
        break
    arr = initDoublyLinkedList[string]()
  arr.append(line)
if arr.len > 0:
  if spawn calc(arr,test) != "":
    echo "trovato ",line
echo "eseguito in ",(cpuTime()-time)

