import nimSHA2
import times


proc find_pwd*(test:string, pwd_file:string)=
  let time = cpuTime()
  for line in lines pwd_file:
    if computeSHA256(line).hex==test:
      echo "trovato ",line
      break
  echo "eseguito in ",(cpuTime()-time)

