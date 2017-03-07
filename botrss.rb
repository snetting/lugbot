#!/usr/bin/ruby

class BOTRSS
  def initialize(rssname)
    @rss_name = rssname
    require 'rss'
    require 'open-uri'
  end

  def rss()
    if @rss_name == "pouet"
      @ran_plat = rand(4)
      case @ran_plat
      when 0
        @platform = 'Amiga'
        @url = 'http://www.pouet.net/export/lastprodsadded.rss.php?platform=Amiga+AGA&platform=Amiga+OCS%2FECS&platform=Amiga+PPC%2FRTG'
      when 1
        @platform = 'ST'
        @url = 'http://www.pouet.net/export/lastprodsadded.rss.php?platform=Atari+ST&platform=Atari+STe'
      when 2
        @platform = 'C64'
        @url = 'http://www.pouet.net/export/lastprodsadded.rss.php?platform=Commodore+64'
      when 3
        @platform = 'ZX 48K'
        @url = 'http://www.pouet.net/export/lastprodsadded.rss.php?platform=ZX+Spectrum'
      when 4
        @platform = 'CPC'
        @url = 'http://www.pouet.net/export/lastprodsadded.rss.php?platform=Amstrad+CPC'
      end
    elsif @rss_name == "cpcwiki"
        @platform = 'CPCWiki'
        @url = 'http://cpcwiki.eu/forum/index.php?type=rss;action=.xml'
    elsif @rss_name == "linux"
        @platform = 'Linux'
        @url = 'http://rss.slashdot.org/Slashdot/slashdotLinux'
        #@url = 'http://cpcwiki.eu/forum/index.php?type=rss;action=.xml'
    else
      return("RSS Error") 
    end
     
    open(@url) do |rss|
      feed = RSS::Parser.parse(rss)
      @feed_length = feed.items.size
      p "- feed length = #{@feed_length}"
    
      @ran_news = rand(@feed_length-1)
  
      feed.items[2].title

      @item_title_raw = feed.items[@ran_news].title
      @item_title = @item_title_raw.gsub(/[^0-9A-Za-z ]/, '')
      @item_link = feed.items[@ran_news].link
      @item_date = feed.items[@ran_news].date
      @result = "Title: #{@item_title}  Link: #{@item_link}  Posted: #{@item_date}"
    end
  return @result
  end
end
