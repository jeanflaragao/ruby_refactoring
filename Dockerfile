FROM ruby:3.3-alpine

# Instalar dependências básicas (necessário para algumas gems nativas)
RUN apk add --no-cache build-base

WORKDIR /app

# Copia o Gemfile para instalar dependências
COPY Gemfile ./

# Instala as gems
RUN bundle install

# Mantém o container disponível
CMD ["irb"]