      *C ABI definitions
      *
      *PUT THIS AT THE TOP OF YOUR FILES!
      *
      *TODO: Fix for 64-bits
       replace off.
       replace also ==:tp-ch:==
           by ==picture s99 usage is computational-5==.
       replace also ==:tp-uch:==
           by ==picture 99 usage is computational-5==.
       replace also ==:tp-sh:==
           by ==picture s9(4) usage is computational-5==.
       replace also ==:tp-ush:==
           by ==picture 9(4) usage is computational-5==.
       replace also ==:tp-int:==
           by ==picture s9(9) usage is computational-5==.
       replace also ==:tp-uint:==
           by ==picture 9(9) usage is computational-5==.
      >>IF COMP64 IS DEFINED
       replace also ==:tp-long:==
           by ==picture 9(18) usage is computational-5==.
       replace also ==:tp-ulong:==
           by ==picture 9(18) usage is computational-5==.
      >>ELSE
       replace also ==:tp-long:==
           by ==usage is pointer==.
       replace also ==:tp-ulong:==
           by ==usage is pointer==.
      >>END-IF
      *
       replace also ==:tp-float:==
           by ==usage is float-short==.
       replace also ==:tp-double:==
           by ==usage is float-long==.
      *
       replace also ==:tp-uint8:==
           by ==picture 99 usage is computational-5==.
       replace also ==:tp-uint16:==
           by ==picture 9(4) usage is computational-5==.
       replace also ==:tp-uint32:==
           by ==picture 9(9) usage is computational-5==.
      >>IF COMP64 IS DEFINED
       replace also ==:tp-uint64:==
           by ==picture 9(18) usage is computational-5==.
       replace also ==:tp-sizet:==
           by ==picture 9(18) usage is computational-5==.
      >>ELSE
       replace also ==:tp-uint64:==
           by ==usage is pointer==.
       replace also ==:tp-sizet:==
           by ==usage is pointer==.
      >>END-IF

