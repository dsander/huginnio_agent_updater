class AgentDataExtractor
  attr_reader :agent_gem

  def initialize
    prepare
  end

  def prepare
    clone
    reset
    bundle
    database
  end

  def load_agents(agent_gem = nil)
    @agent_gem = agent_gem
    bundle if agent_gem
    Dir.chdir('huginn') do
      output = shell_out("bundle exec rails runner #{__dir__}/extract_huginn_agents_script.rbx", 'Loading Agents ...')
      JSON.parse(output)
    end
  end

  private

  def clone
    unless File.exists?('huginn/.git')
      shell_out("git clone https://github.com/cantino/huginn.git -b master huginn", 'Cloning huginn source ...')
    end
  end

  def reset
    Dir.chdir('huginn') do
      shell_out("git fetch && git reset --hard origin/master", 'Resetting Huginn source ...')
    end
  end

  def bundle
    if File.exists?('.env')
      shell_out "cp .env huginn"
    end
    Dir.chdir('huginn') do
      shell_out("bundle install --without test development -j 4", 'Installing ruby gems ...')
    end

  end

  def database
    Dir.chdir('huginn') do
      shell_out('bundle exec rake db:create db:migrate', 'Creating database ...')
    end
  end

  def shell_out(command, message = nil)
    print message if message

    output = Bundler.with_clean_env do
      ENV['ADDITIONAL_GEMS'] = agent_gem if agent_gem
      ENV['RAILS_ENV'] = 'production'
      ENV['APP_SECRET_TOKEN'] = '123456789'
      `#{command}`
    end

    if $?.success?
      puts "\e[32m [OK]\e[0m" if message
    else
      puts "\e[31m [FAIL]\e[0m" if message
      puts "Tried executing '#{command}'"
      puts output
      fail
    end
    output
  end
end
