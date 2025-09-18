require 'http'
require 'json'
require 'dotenv'
require 'pry'
Dotenv.load
# n'oublie pas les lignes pour Dotenv ici…

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/chat/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

puts "que souhaites-tu savoir ?"

messages = []

loop do
  print "Vous: "
  prompt_string = gets.chomp
  break if prompt_string.strip.downcase == "exit"

  # Ajouter la demande de l'utilisateur à l'historique
  messages << { "role" => "user", "content" => prompt_string }

  # Préparer les données à envoyer
  data = {
    "model" => "gpt-4o",
    "messages" => messages,
    "max_tokens" => 150,
    "temperature" => 0.1
  }

  # Envoyer la requête
  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)

  # Extraire la réponse de l'assistant
  response_string = response_body.dig("choices", 0, "message", "content")
  puts "Bot: #{response_string}"

  # Ajouter la réponse du bot à l'historique
  messages << { "role" => "assistant", "content" => response_string }

end

# ligne qui permet d'envoyer l'information sur ton terminal