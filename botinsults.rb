

class INSULTS

  def initialize(db)
    @insultsname=db
    @database = Array.new
  end

  def load
    if File.exist?("#{@insultsname}")
      p "- Found existing #{@insultsname}"
      @database = IO.readlines("#{@insultsname}")
      p "- imported #{@database.size} insults"
      return @database.size
    else
      p "- #{@insultsname} not found"
    end
  end

  def insult()
      #result = @database.sample(1)
      #result = self[rand(length)]
      @dbsize = @database.length
      @rando = rand(@dbsize)
      @retval = @database[@rando]
      return @retval
  end

end

