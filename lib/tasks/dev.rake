namespace :dev do
  desc "Make the initial setup of develop environment"
  task setup: :environment do
    unless Rails.env.production?
      show_spinner("Deleting current db...") { %x(rails db:drop) }
      show_spinner("Creating new db...") { %x(rails db:create) }
      show_spinner("Runnig migrations...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Task available only in development or test environment."
      puts "You are in: #{Rails.env}"
    end
  end
  
  desc "Add some initial coins to Coin"
  task add_coins: :environment do
    show_spinner("Adding some coins...") do
      coins = [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png",
          mining_type: MiningType.find_by(acronym: 'PoW')
        },
        {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR4wTJ-nU4OkDJt02URgKpfXMgUOm_reKePSJS-XRxrQ2aujPCC&usqp=CAU",
          mining_type: MiningType.all.sample
        },
        {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://www.pngkit.com/png/detail/135-1353048_dash-icon-dash-coin-logo-png.png",
          mining_type: MiningType.all.sample
        }
      ]
      
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Add initial mining types to MiningTypes"
  task add_mining_types: :environment do
    show_spinner("Adding some mining types...") do
      mining_types = [
        {
          description: "Proof of Work",
          acronym: "PoW"
        },
        {
          description: "Proof of Stake",
          acronym: "PoS"
        },
        {
          description: "Proof of Capacity",
          acronym: "PoC"
        }
      ]
      
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end
  
  private 
  
  def show_spinner(msg_start, msg_end="(Done!)")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :arrow_pulse)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end

end
