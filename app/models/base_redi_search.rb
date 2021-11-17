class BaseRediSearch
  include ActiveModel::Conversion
  include ActiveModel::Model

  INDEX_NAME = 'Define in a child class'
  SCHEMA = { key: 'Define in a child class' }

  attr_accessor :id, *self::SCHEMA.keys

  def self.count
    index.document_count
  end

  def self.search(text)
    documents = index.search(text).sort_by(:title, order: :asc)
    documents.to_a.map { |d| poro(d) }
  end

  def self.build(attributes = {})
    attributes[:id] ||= SecureRandom.hex

    new(attributes)
  end

  def self.find(id)
    poro(RediSearch::Document.get(index, id))
  end

  def self.delete_all
    index.drop
  end

  def self.init_index
    index.create
  end

  def update(attributes)
    attributes.each do |field, value|
      send("#{field}=", value)
    end
    save
  end

  def save
    self.class.index.add(document)
  end

  def delete
    document.del
  end

  private

  def self.index
    RediSearch::Index.new(self::INDEX_NAME, self::SCHEMA)
  end

  def document
    RediSearch::Document.for_object(self.class.index, self)
  end

  def self.poro(document)
    build(document.attributes.merge!(id: document.document_id_without_index))
  end
end