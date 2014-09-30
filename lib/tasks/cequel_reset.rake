namespace :cequel do
  desc "Reset the cequel environment by dropping and reinitializing."
  task :reset => %w[cequel:keyspace:drop cequel:init]

  namespace :reset do
    rake_cmd = "RAILS_ENV=%{environment} rake %{task}"
    desc "Reset all cequel environments"
    task :all do
      config = YAML.load(ERB.new(File.read("config/cequel.yml")).result)
      config.each do |environment, configuration|
        next unless configuration["keyspace"]
        next if configuration["hosts"]
        next unless configuration["host"]
        next unless %w[
          127.0.0.1
          0.0.0.0
          localhost
          ::1
        ].include?(configuration["host"])

        cmd = rake_cmd % { environment: environment, task: "cequel:keyspace:drop" }
        puts "running #{cmd}"
        unless system(cmd)
          raise "#{cmd} failed. Aborting rake"
        end

        cmd = rake_cmd % { environment: environment, task: "cequel:init" }
        puts "running #{cmd}"
        unless system(cmd)
          raise "#{cmd} failed. Aborting rake"
        end
      end
    end
  end
end
