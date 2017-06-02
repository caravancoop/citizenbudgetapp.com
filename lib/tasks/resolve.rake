namespace :assets do
  desc "Resolve assets"
  task :resolve => :environment do
    # Resolve relative paths in CSS
    Dir['bower_components/**/*.css'].each do |filename|
      contents = File.read(filename) if FileTest.file?(filename)
      # http://www.w3.org/TR/CSS2/syndata.html#uri
      url_regex = /url\((?!\#)\s*['"]?(?![a-z]+:)([^'"\)]*)['"]?\s*\)/

      # Resolve paths in CSS file if it contains a url
      if contents =~ url_regex
        directory_path = Pathname.new(File.dirname(filename))
        .relative_path_from(Pathname.new('bower_components'))

        # Replace relative paths in URLs with Rails asset_path helper
        new_contents = contents.gsub(url_regex) do |match|
          relative_path = $1
          image_path = directory_path.join(relative_path).cleanpath
          puts "#{match} => #{image_path}"

          "url(<%= asset_path '#{image_path}' %>)"
        end

        # Replace CSS with ERB CSS file with resolved asset paths
        FileUtils.rm(filename)
        File.write(filename + '.erb', new_contents)
      end
    end
  end
end