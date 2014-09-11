require 'yaml'
require 'erb'
require 'colorize'

# require 'ruby-progressbar'
# Progressbar integration:
# total = 0
# publications.to_a.each { |p| total += p.last.count }
# progressbar = ProgressBar.create(starting_at: 0, total: total, length: 70)
#
# progressbar.increment

namespace :vagrant do
  namespace :commands do
    desc 'Delete and regenerate build folder'
    task :reset do
      puts 'Resetting build folder'.colorize(:green)
      `rm -rf build`
      `mkdir build`
    end

    desc 'Copy in build folder commands generated from config/proxies.yml'
    task :build do
      begin
        puts 'Building vagrant commands'.colorize(:green)
        template_path = 'templates/vagrant_command.sh.erb'
        cnf = YAML.load(File.open('config/proxies.yml'))

        publications = cnf['publication']
        publications.keys.each do |publication|
          publications[publication].tap do |folders|
            folders.keys.each do |folder|
              file_name = folders[folder]
              content = ERB.new(File.read(template_path)).result(binding)
              File.open("build/rb#{file_name}.sh", 'w+') do |file|
                file.write(content)
                print '.'
              end
            end
          end
        end
        `cp bin/proxy_command.sh build/`
        puts ''
      rescue StandardException => e
        puts 'ERROR! Verify you have created a config/proxies.yml file.'
        puts e
      end
    end

    desc 'Create symlinks from build commands to user local bin folder'
    task :symlink do
      puts 'Symlinking vagrant commands'.colorize(:green)
      cwd = Dir.pwd
      Dir.foreach('./build/') do |file_name|
        next if file_name == '.' || file_name == '..'
        command = file_name[/\w+/]
        file_path = "#{cwd}/build/#{file_name}"
        system "chmod +x #{file_path}; " \
          "ln -s -f '#{file_path}' /usr/local/bin/#{command}"
        print '.'
      end
      puts ''
    end

    desc 'Delete symlinks from user local bin folder'
    task :delete do
      puts 'Deleting vagrant commands'.colorize(:green)
      Dir.foreach('./build/') do |file_name|
        next if file_name == '.' || file_name == '..'
        command = file_name[/\w+/]
        system "rm /usr/local/bin/#{command}"
        print '.'
      end
      puts ''
    end

    task create: %w(delete reset build symlink)
  end
end

task default: 'vagrant:commands:create'
