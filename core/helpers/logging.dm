// Shims for logging procs to make porting code easier.

#define LOGLINE(source,content) "\[[time2text(world.realtime, "hh:mm:ss")]\] [source]: [content]"
/var/global/log_end = world.system_type == UNIX ? ascii2text(13) : ""

/proc/log_mc(msg)
	world.log << LOGLINE("MASTER", msg)

/proc/log_gc(text)
	world.log << LOGLINE("GC", text)

/proc/log_notice(msg)
	world << LOGLINE("NOTICE", msg)

/proc/log_ss(subsystem, text, log_world = TRUE)
	world.log << LOGLINE("SS[subsystem || "???"]", text)
	if (log_world)
		world << LOGLINE("SS[subsystem || "???"]", text)

/proc/log_game(text)
	world.log << LOGLINE("GAME", text)

/proc/log_debug(text)
	world.log << LOGLINE("DEBUG", text)

/proc/log_warning(text)
	world.log << LOGLINE("WARNING", text)

#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
//print a warning message to world.log
/proc/warning(msg)
	world.log <<  "## WARNING: [msg][log_end]"

//print a testing-mode debug message to world.log
/proc/testing(msg)
	world.log <<  "## TESTING: [msg][log_end]"

#define admin_notice(msg, perms) log_notice(msg)
#define message_admins(msg) log_notice(msg)