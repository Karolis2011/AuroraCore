// -- SSprocessing stuff --
#define START_PROCESSING(Processor, Datum) if (!Datum.isprocessing) {Datum.isprocessing = 1;Processor.processing += Datum}
#define STOP_PROCESSING(Processor, Datum) Datum.isprocessing = 0;Processor.processing -= Datum

/// START specific to SSmachinery
#define START_PROCESSING_MACHINE(machine, flag)\
	if(!istype(machine, /obj/machinery)) CRASH("A non-machine [log_info_line(machine)] was queued to process on the machinery subsystem.");\
	machine.processing_flags |= flag;\
	START_PROCESSING(SSmachinery, machine)

/// STOP specific to SSmachinery
#define STOP_PROCESSING_MACHINE(machine, flag)\
	machine.processing_flags &= ~flag;\
	if(machine.processing_flags == 0) STOP_PROCESSING(SSmachinery, machine)

// -- SStimer stuff --
//Don't run if there is an identical unique timer active
#define TIMER_UNIQUE		(1<<0)

//For unique timers: Replace the old timer rather then not start this one
#define TIMER_OVERRIDE		(1<<1)

//Timing should be based on how timing progresses on clients, not the sever.
//	tracking this is more expensive,
//	should only be used in conjuction with things that have to progress client side, such as animate() or sound()
#define TIMER_CLIENT_TIME	(1<<2)

//Timer can be stopped using deltimer()
#define TIMER_STOPPABLE		(1<<3)

//To be used with TIMER_UNIQUE
//prevents distinguishing identical timers with the wait variable
#define TIMER_NO_HASH_WAIT  (1<<4)

//Loops the timer repeatedly until qdeleted
//In most cases you want a subsystem instead
#define TIMER_LOOP			(1<<5)

//number of byond ticks that are allowed to pass before the timer subsystem thinks it hung on something
#define TIMER_NO_INVOKE_WARNING 600

#define TIMER_ID_NULL -1

// -- SSatoms stuff --
// Technically this check will fail if someone loads a map mid-round, but that's not enabled right now.
#define SSATOMS_IS_PROBABLY_DONE (SSatoms.initialized == INITIALIZATION_INNEW_REGULAR)

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
    ..();\
    if(!initialized) {\
        args[1] = TRUE;\
        SSatoms.InitAtom(src, args);\
    }\
}

// 	SSatoms Initialization state.
#define INITIALIZATION_INSSATOMS 0	//New should not call Initialize
#define INITIALIZATION_INNEW_MAPLOAD 1	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR 2	//New should call Initialize(FALSE)

//	Initialize() hints for SSatoms.
#define INITIALIZE_HINT_NORMAL 0    //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL 2  //Call qdel on the atom
#define INITIALIZE_HINT_LATEQDEL 3	//Call qdel on the atom instead of LateInitialize
