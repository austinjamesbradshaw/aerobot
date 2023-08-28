EXE      = example
FTN      = gfortran
#FTN      = f90
OPTIONS1 = -m64 #-g
OPTIONS2 = -m64 #-g
#LIBS     = /usr/people/cizmas/util/32/grafic/graficV3/libgrafic.a  -lX11
LIBS     = 

OBJECTS =      \
   cpv.o       \
   gamma_rat.o \
   hps_air.o   \
   hps_lambda.o\
   hs_air.o    \
   1hs_lambda.o\
   hs_sto.o    \
   mainV11a.o  \
   myspline.o  \
   rootbis.o   \
   sfunc.o     \
   spline16.o  \
   splint.o    \
   st_func.o   \
   th_air.o    \
   th_sto.o    \
   ts_air.o    \
   ts_lambda.o \
   ts_sto.o    \
   tu_air.o    \
   tu_sto.o    \
   1th_lambda.o


#.SUFFIXES:      
.SUFFIXES: .o .f .f90

.f.o    :  ; $(FTN) $(OPTIONS1) -c $*.f
.f90.o  :  ; $(FTN) $(OPTIONS1) -c $*.f90

$(EXE) : $(OBJECTS) ; $(FTN) $(OPTIONS2) -o $(EXE) $(OBJECTS) $(LIBS)

$(OBJECTS):
 
