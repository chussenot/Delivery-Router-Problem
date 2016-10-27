Bundler.require :default

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
  # other
  def camelize
    split(/[^a-z0-9]/i).map(&:capitalize).join
  end

  def classify
    split('/').map(&:camelize).join('::')
  end
end

# Autoload classes
def autoload_all(root, pattern)
  Dir[File.join(root, pattern)].tap do |files|
    files.each do |file|
      autoload(File.basename(file, '.rb').classify.to_sym, file)
    end
    files.each { |file| require(file) }
  end
end

autoload_all '.', '{lib}/**/*.rb'
