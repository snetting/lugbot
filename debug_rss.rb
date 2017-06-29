#!/usr/bin/ruby
require 'rubygems'
require './botrss'

        RSSFEED = "linux"
        myRSS = BOTRSS.new(RSSFEED)

      response = myRSS.rss()
      puts "Answered: #{response}" 
