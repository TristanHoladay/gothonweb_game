class UserValidator
  def initialize(name, password, names)
    @name = name
    @password = password
    @names = names
  end

  def valid?
    validate
    @message.nil?
  end

  def message
    @message
  end

  private

  # this is a rough draft, the code needs to check
  # that password is tied to the name
  # also (and i think the uniq code in storing names does this)
  # if a name already exists when people sign up then it needs to
  # require another username
  def validate
    if @name.empty?
      @message = "Please input a username."
    elsif @password.empty?
      @message = "Please input a password."
    elsif @names.include?(@name) == false
      @message = "That username does not exist. Please make sure to check your spelling."
    elsif @names.include?(@password) == false
      @message = "Wrong password. Please check your spelling and try again."
    elsif @names.include?(@name) && @names.include?(@password)
      @message = "Welcome {@name}"
    end
  end
end
