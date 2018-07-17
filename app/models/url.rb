class Url < ApplicationRecord
  belongs_to :user, optional: true

  validates :origin, format: { with: URI::regexp(%w(http https)),
                               message: 'Must start with \'http\' or \'https\'.' }
  validates :shortened, uniqueness: { message: 'Has already been taken.' },
                        format: { without: /[ ;\?\/:@=&"<>#%\{\}\|\\^~\[\]`]/,
                                  message: 'Can\'t use the following characters. ;?/:@=&"<>#%{}|\^~[]`' },
                        presence: true

  validate :check_same_url

  after_initialize :set_default

  def set_default
    self.shortened = random_shortened if self.shortened.blank?
  end

  def self.shortened_to_origin shortened
    find_by_shortened(shortened)&.origin
  end

  private

    def random_shortened
      [*('A'..'Z'),*('a'..'z'),*('0'..'9')].sample(5).join      
    end

    def check_same_url
      match_data = origin.match(URI::regexp)
      errors.add :origin, "Can't be the same as the shortened URL." if match_data[7] == "/#{shortened}" && match_data[4] == 'zzu.li'
    end
end
