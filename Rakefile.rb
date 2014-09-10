desc 'Default task'
task :default do
  cwd = Dir.pwd
  # Generate script
  script = []
  # Create symbolic links for each command
  bin_list = [:hiclone, :hiclonechef, :proxy_command, :proxy_backend,
              :proxy_frontend, :proxy_backend_core]
  bin_list.each do |cmd|
    file_path = "#{cwd}/bin/#{cmd}.sh"
    script << "chmod +x #{file_path}"
    script << "ln -s -f '#{file_path}' /usr/local/bin/#{cmd}"
  end
  script = script.join ";\n"
  # Run script
  puts script
  exec(script)
end
