module StoringNames

  # needs to store password as well
  def store_users(filename, string1, string2)
    File.open(filename, "a+") do |file|
      user_creds = [string1, string2]
      file.puts(user_creds)
    end
  end

  # not sure if this method is necessary,
  # or if it needs to be changed to a checker method
  def read_user_creds
    return [] unless File.exist?("names.txt")
    #clean_file = File.read("names.txt").split("\n")
    clean_file.uniq
  end
end
