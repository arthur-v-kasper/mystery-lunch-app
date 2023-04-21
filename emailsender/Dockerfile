FROM ruby:3.1.2

# Instala as dependências do sistema necessárias
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Cria e define o diretório de trabalho
RUN mkdir /emailsender
WORKDIR /emailsender

# Copia o Gemfile e instala as gems necessárias
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler -v 2.4.10
RUN bundle install

# Copia todo o diretório do aplicativo para a imagem
COPY . .

# Expõe a porta 4567 (porta padrão do Sinatra)
EXPOSE 4567

# Define o comando para iniciar o aplicativo Sinatra
CMD ["ruby", "sender.rb"]
