#!python
#cython: boundscheck=False
#cython: wraparound=False


cdef class Core:
    cdef dict files
    cdef dict folders
    cdef list batches

    @staticmethod
    cdef register(FileBatch fb):
        Core.batches.append(fb)


cdef class FileBatch:

    cdef list file_indices
    cdef list folder_indices
    cdef dict modes

    cpdef collapse_to(self, int depth):
        pass

    cpdef move_to(self, str path):
        pass

    cpdef get_duplicates(self, FileBatch other):
        pass

    cpdef get_added(self, FileBatch other):
        pass

    cpdef get_removed(self, FileBatch other):
        pass

    cpdef set_mode(self, mode):
        if type(mode) is slice:
            pass
        else:
            mode_bool = True if mode[0] == "+" else False
            mode_name = mode[0: (len(mode) - 1)]
            self.modes[mode_name] = mode_bool

    cpdef set_modes(self, tuple modes):
        cdef mode
        for mode in modes:
            self.set_mode(mode)

    def __init__(self):
        self.file_indices = list()
        self.folder_indices = list()
        self.modes = {"F": True, "D": True}
        Core.register(self)

    def __mul__(self, FileBatch other):
        return self.get_duplicates(other)

    def __sub__(self, FileBatch other):
        return self.get_removed(other)

    def __add__(self, FileBatch other):
        return self.get_added(other)

    def __rshift__(self, str path):
        self.move_to(path)

    def __lshift__(self, int depth):
        self.collapse_to(depth)

    def __getitem__(self, modes):
        if type(modes) is tuple:
            self.set_modes(modes)
        else:
            self.set_mode(modes)
        return self
