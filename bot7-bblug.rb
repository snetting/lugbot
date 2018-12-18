#!/usr/bin/ruby
require 'rubygems'
require 'isaac'
require './botdb'
require './botrss'
require './botinsults'

	CHNL = "bblug"
	DBFILE = CHNL+".dat"
        INSULTFILE = CHNL+".insults"
        RSSFEED = "linux"
	myDB = DB.new(DBFILE)
        myRSS = BOTRSS.new(RSSFEED)
        myINSULTS = INSULTS.new(INSULTFILE)

        rand_topic = 200
        rand_insult = 180 

configure do |c|
 c.nick    = "LUGBOT"
 c.server  = "IRC.PERL.ORG"
 c.port    = 6667
end


on :connect do
  join "##{CHNL}"
  myDB.load
  myINSULTS.load
end

on :private, /^dbsize/ do
  msg nick, "#{myDB.size}"
end

on :private, /^load/ do
	p "Reading file"
	msg nick, "- Read #{myDB.load} facts"	
end

on :private, /^save/ do
	msg nick, "- Saved #{myDB.save} facts"
end

on :private, /^help/ do
	msg nick, "I can 'load' and 'save' my DB, return my 'dbsize' and also 'op' trusted users."
end	

# Priv request for ops - only given to trusted users
on :private, /^op/ do
        mode "#bblug", "+o spirit3"
        mode "#bblug", "+o Syd"
        mode "#bblug", "+o OH3SPN"
        #raw "OPER #bblug +o OH3SPN"
        #raw ("OPER #bblug -o OH3SPN")
        msg nick, "Ops given to trusted users."
end

# Add regex to catch and kick spammers
on :channel, /(.*)(ATTN|ATTΝ|οsirislab)(.*)/ do
        puts "Caught banhammer flag"
        puts "#{nick} bblug goodbye"
        kick "#bblug", "#{nick}", "Expecto Patronum!"
        #raw "kick #{nick} #bblug Goodbye"
end

#on :private, /^search (.*)/ do
on :channel, /(.*)/ do
  input = match[0]
  puts "Caught input: #{input}"
  if input.start_with?("LUGBOT:") || input.start_with?("lugbot:") then
    stermstring = input.downcase.gsub!(/^lugbot:/, "")
    if input.include?("rss") || input.include?("RSS") then
      response = myRSS.rss()
    else
      puts "Asked: #{stermstring}"
      response = myDB.query(stermstring)
    end
    msg channel, "#{response}"
    puts "Answered: #{response}" 
  elsif rand(rand_topic) == 2 then
    # random topical response, also add input to DB
    puts "Grabbed: #{input}"
    sleep(5)
    response = myDB.query(input)
    msg channel, "#{response}"
    puts "Answered: #{response}"
    input.gsub!(/^[a-zA-Z0-9^_-]{1,12}:/, "")
    myDB.append(input)
  elsif rand(rand_insult) == 13 then
    # Random insult, also add input to DB
    response = myINSULTS.insult()
    msg channel, "#{response}"
    puts "Insulted: #{response}"
    # Add input to DB
    input.gsub!(/^[a-zA-Z0-9^_-]{1,12}:/, "")
    myDB.append(input)
  else
    # just add to DB
    input.gsub!(/^[a-zA-Z0-9^_-]{1,12}:/, "")
    myDB.append(input)
  end
end
