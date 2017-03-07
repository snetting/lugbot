

class SULTS

  def initialize(db)
    @sultsname=db
    @database = Array.new
  end

  def load
    if File.exist?("#{@sultsname}")
      p "- Found existing #{@sultsname}"
      @database = IO.readlines("#{@sultsname}")
      p "- imported #{@database.size} insults"
      return @database.size
    else
      p "- #{@sultsname} not found"
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

