class Language
  def initialize(name)
    @name = name
  end

  def self.all
    [Language.new('Ruby'), Language.new('Python'), Language.new('Elixir')]
  end

  private

  def name
    @name
  end
end
