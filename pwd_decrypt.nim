# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import os 
#import mono_thread
import multi_thread



when isMainModule:
  if not declared(paramCount) or paramCount() < 2:
    echo "Use: \npwd_decrypt hash_to_decrypt path_to_pwd_file"
    echo "example: pwd_decrypt C13E9A4D0D5E496368B4F2E9162007ABA675719EBFB414F181439BFBE0FE58E5 /home/salvo/Scaricati/HashesOrg"
    echo "the result should be: ядевушка29июля22июля"
  else:
    find_pwd(paramStr(1),paramStr(2))
