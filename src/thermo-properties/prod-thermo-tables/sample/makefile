CFT      = gfortran
FFLAGS   = 
LDFLAGS  = 
LIBS     = 
EXE      = ta
VPATH    = mod

.SUFFIXES:
.SUFFIXES: .f90 .o #.mod

.f90.o:
	$(CFT) $(FFLAGS) $*.f90 

SRCMAIN  = main.f90       \
	control.f90       \
	ratint.f90        \
	readtable.f90	  \
	startup.f90

SRCMOD = th.f90

OBJMAIN = ${SRCMAIN:.f90=.o}

OBJMOD = ${SRCMOD:.f90=.o}

OBJS = $(OBJMOD) $(OBJMAIN)

# Now define the dependencies for the executable

$(EXE):	$(OBJS) 
	$(CFT) $(OBJS) $(LDFLAGS) -o $(EXE) $(LIBS)

%.o  : %.f90 
	$(CFT) $(FFLAGS) -c $<

# Define dependencies for modules
$(OBJMAIN): $(OBJMOD)






