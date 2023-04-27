Modules
###################

.. toctree::
    :maxdepth: 1
    :glob:

    *

| after some profiling, I realize that either inlining has to be done for low level functions
| or if not possible, the functions have to be inlined in the header file
| the performance difference is in the 100x
