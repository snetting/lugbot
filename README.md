# lugbot
Ruby IRC Bot
Also known as dickbot, erisbot and others.

Requires Ruby 1.8.7 (rvm use ruby-1.8.7).

Database file created if missing on startup.  For testing, add a heap of facts to the .dat once created then /msg the bot 'load'.  For testing, the supplied 'testdb.dat' (containing discordian quotes) can be renamed.  When testing, please rename the bot (several changes required to main ruby file - TODO: determine search strings from variable name). 

The bot responds to anything asked publically; lines starting 'lugbot:' or 'LUGBOT:'.  Direct (/msg) commands are simply 'dbsize', 'load' and 'save' (save being redundant as save is automatic when a new 'fact' is added).

Messages sent publically but targeting a specific user (starting <username>:) are ignored.  General public messages are added to the database.

steve@netting.org.uk
