# Customizing Pry configuration
Pry.config.pager = false
Pry.config.editor = "nano"
Pry.config.prompt = [ proc { |obj, nested| "#{ nested == 0 ? "?" : nested }> " }, proc { |obj, nested| " | "+nested.times.map { " " }.join } ]

# Load Rails environment if current folder is a Rails App
File.file?("./config/environment.rb") && require("./config/environment.rb")
