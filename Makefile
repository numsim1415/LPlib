

#-----------------------------------------------------------#
#															#
#			LoopParallelism Library	V3.0					#
#															#
#-----------------------------------------------------------#
#															#
#	Description:		Handles threads, scheduling			#
#						& dependencies						#
#	Author:				Loic MARECHAL						#
#	Creation date:		feb 25 2008							#
#	Last modification:	mar 12 2010							#
#															#
#-----------------------------------------------------------#


CC     = /usr/bin/gcc
CFLAGS =  -O3


# Working directories

LIBDIR  = $(HOME)/lib/$(ARCHI)
INCDIR  = $(HOME)/include
SRCSDIR = sources
OBJSDIR = objects/$(ARCHI)
ARCHDIR = archives
DIRS    = objects $(LIBDIR) $(OBJSDIR) $(ARCHDIR) $(INCDIR)
VPATH   = $(SRCSDIR)


# Files to be compiled

SRCS = $(wildcard $(SRCSDIR)/*.c)
HDRS = $(wildcard $(SRCSDIR)/*.h)
OBJS = $(patsubst $(SRCSDIR)%, $(OBJSDIR)%, $(SRCS:.c=.o))
LIB = lplib3.a


# Definition of the compiling implicit rule

$(OBJSDIR)/%.o : $(SRCSDIR)/%.c
	$(CC) -c $(CFLAGS) -I$(SRCSDIR) $< -o $@


# Install the library

$(LIBDIR)/$(LIB): $(DIRS) $(OBJS)
	cp $(OBJSDIR)/lplib3.o $@
	cp $(SRCSDIR)/*lplib3.h $(SRCSDIR)/*lplib3.ins $(INCDIR)


# Objects depends on headers

$(OBJS): $(HDRS)


# Build the working directories

$(DIRS):
	@[ -d $@ ] || mkdir $@


# Remove temporary files

clean:
	rm -f $(OBJS) $(LIBDIR)/$(LIB)

# Build a dated archive including sources, patterns and makefile

tar: $(DIRS)
	tar czf $(ARCHDIR)/lplib3.`date +"%Y.%m.%d"`.tgz sources Makefile

zip: $(DIRS)
	archive_lp3.sh
