<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Chatbot Ruby avec OpenAI GPT-4o</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      background-color: #f9f9f9;
      color: #333;
    }

    h1, h2, h3 {
      color: #2c3e50;
    }

    pre {
      background-color: #2d2d2d;
      color: #f8f8f2;
      padding: 20px;
      border-radius: 8px;
      overflow-x: auto;
      line-height: 1.5;
    }

    code {
      font-family: 'Courier New', Courier, monospace;
    }

    .section {
      margin-bottom: 40px;
    }

    ul {
      line-height: 1.6;
    }

    .important {
      background-color: #fff3cd;
      padding: 10px 15px;
      border-left: 4px solid #ffc107;
      border-radius: 4px;
      margin-top: 10px;
    }

    a {
      color: #007bff;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

  </style>
</head>
<body>

  <h1>🤖 Chatbot Ruby avec OpenAI GPT-4o</h1>

  <div class="section">
    <p>Ce projet est un <strong>chatbot en ligne de commande</strong> développé en Ruby, utilisant l’API <code>gpt-4o</code> d’OpenAI. Il conserve l’historique des échanges pour permettre un dialogue fluide et contextuel avec l’intelligence artificielle.</p>
  </div>

  <div class="section">
    <h2>⚙️ Prérequis</h2>
    <ul>
      <li>Ruby (version 2.6 ou supérieure)</li>
      <li>Clé API OpenAI</li>
      <li>Gems : <code>http</code>, <code>json</code>, <code>dotenv</code>, <code>pry</code> (optionnelle)</li>
    </ul>
  </div>

  <div class="section">
    <h2>🛠 Installation</h2>
    <ol>
      <li><strong>Créer un fichier</strong> Ruby, par exemple <code>chatbot.rb</code>.</li>
      <li><strong>Installer les gems nécessaires</strong> :
        <pre><code>gem install http json dotenv pry</code></pre>
      </li>
      <li><strong>Créer un fichier <code>.env</code></strong> à la racine du projet :
        <pre><code>OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</code></pre>
      </li>
    </ol>
  </div>

  <div class="section">
    <h2>🚀 Utilisation</h2>
    <p>Lance le chatbot dans ton terminal :</p>
    <pre><code>ruby chatbot.rb</code></pre>

    <p>Exemple :</p>
    <pre><code>que souhaites-tu savoir ?
Vous: Quelle est la capitale de la Norvège ?
Bot: La capitale de la Norvège est Oslo.</code></pre>

    <p>Tapez <code>exit</code> pour quitter la conversation.</p>
  </div>

  <div class="section">
    <h2>📄 Code source</h2>
    <pre><code>require 'http'
require 'json'
require 'dotenv'
require 'pry'

Dotenv.load

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/chat/completions"

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

  messages &lt;&lt; { "role" => "user", "content" => prompt_string }

  data = {
    "model" => "gpt-4o",
    "messages" => messages,
    "max_tokens" => 150,
    "temperature" => 0.1
  }

  response = HTTP.post(url, headers: headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)

  response_string = response_body.dig("choices", 0, "message", "content")
  puts "Bot: #{response_string}"

  messages &lt;&lt; { "role" => "assistant", "content" => response_string }
end
</code></pre>
  </div>

  <div class="section">
    <h2>🧠 Fonctionnement</h2>
    <ul>
      <li>Garde en mémoire l’historique de la conversation.</li>
      <li>Envoie cet historique à l’API <code>gpt-4o</code> pour conserver le contexte.</li>
      <li>Affiche les réponses dans le terminal.</li>
    </ul>
  </div>

  <div class="section">
    <h2>🛡️ Sécurité</h2>
    <div class="important">
      ⚠️ <strong>Ne partagez jamais votre clé API.</strong> Le fichier <code>.env</code> doit rester privé.
    </div>
  </div>

  <div class="section">
    <h2>📌 Améliorations possibles</h2>
    <ul>
      <li>Limiter la taille de l’historique (éviter les erreurs de contexte trop long).</li>
      <li>Sauvegarder les conversations dans un fichier (.txt ou .json).</li>
      <li>Créer une interface graphique ou web.</li>
    </ul>
  </div>

  <div class="section">
    <h2>📃 Licence</h2>
    <p>Ce projet est destiné à des fins éducatives. Respectez les <a href="https://openai.com/policies/usage-policies" target="_blank">conditions d’utilisation d’OpenAI</a>.</p>
  </div>

</body>
</html>