Encoding.default_external = "utf-8"
# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "css"
sass_dir = "_sass"
images_dir = "img"
javascripts_dir = "js"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false
line_comments = false

# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

# Boolean Set this to true to enable sourcemap output.
sourcemap = true

cache = false

# color compress
require "sass"

module Sass::Script::Value
  class Color
    def to_s(opts = {})
      return rgba_str if alpha?
      return smallest# if options[:style] == :compressed
      #return COLOR_NAMES_REVERSE[rgb] if COLOR_NAMES_REVERSE[rgb]
      hex_str
    end
  end
end

# sprite image name
require 'fileutils'
on_sprite_saved do |filename|
  if File.exists?(filename)
    FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, ".png")
  end
end

on_stylesheet_saved do |filename|
  if File.exists?(filename)
    css = File.read filename
    File.open(filename, 'w+') do |f|
      f << css.gsub(%r{-s[a-z0-9]{10}\.png}, ".png")
    end
  end
end
