# SLIM-FS
A ultra compact file system written in BASH

## \~A small ASCII-based file-system.\~  
_SLIM-FS!_  
...is my attempt to write an ultra compact file system that is more transparent than any other.  
The index entries consist only of ASCII characters (excluding zero bytes, as these are created during formatting).  
---  
  
  
  
The file system header is exactly 32 bytes.  
`SLIM-FS!01500000DISKETTE_A␠␠␠␠␠␠`  
```
header(8),size(8),label(16)
[ HEADER ][DISKSIZE][   DISK-LABEL   ]
[SLIM-FS!][01500000][DISKETTE_A      ]
```  
\*The header is padded to 32 bytes with spaces.  
  
---  
  
Each index entry is also exactly 32 bytes in size.  
`DOCUMENT␠A.TXT␠␠0003200100000005`  
```
filename(16),offset(8),size(8)
[    FILENAME    ][ OFFSET ][  SIZE  ]
[DOCUMENT A.TXT  ][00032001][00000005]
```  
\*The filename is padded to 32 bytes with spaces (At the moment, i use question-marks for testing some behaviours of the interpreter).  
  
---  
  
- The file starts at the 32001th byte of the data carrier.  
- The file says 'Hello' (5 bytes)  
  
If an entry begins with a '?', the entry is free or has been deleted.  
Only the question mark is written, so recovery (with loss of the first character of the file name) is possible.  
---  
---  
  
## At the moment you can:  
- format a data carrier  
- create empty file entries in the index  
---  
---  
  
## Planned functions:  
- Write data to files  
- Read data from files  
- Delete files  
- Restore files  
- Delete files unrecoverably  
- search files  
---  
---  
  
## DATA-BLOCK  
The index currently consists of 999 entries.  
Header(32) + Index (999*32) = 32000  
The data block starts with the 32001st byte.  
  
  
  
