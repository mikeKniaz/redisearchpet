class Story < BaseRediSearch
  INDEX_NAME = 'stories'.freeze
  SCHEMA = { title: { text: { weight: 3, phonetic: 'dm:en', sortable: true } },
             ganre: { text: { weight: 2, phonetic: 'dm:en' } },
             body: { text: { weight: 1, phonetic: 'dm:en' } } }.freeze
  GANRES = %w[Comedy Drama Horror Realism Romance Satire Tragedy Thriller Fantasy].freeze

  attr_accessor :id, *self::SCHEMA.keys
end
