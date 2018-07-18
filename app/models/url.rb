class Url < ApplicationRecord
  belongs_to :user, optional: true

  # validates :origin, format: { with: URI::regexp(%w(http https)),
  #                              message: 'Must start with \'http\' or \'https\'.' }
  validate :format_of_origin
  validates :shortened, uniqueness: { message: 'Has already been taken.' },
                        format: { without: /[ ;\?\/:@=&"<>#%\{\}\|\\^~\[\]`]/,
                                  message: 'Can\'t use the following characters. ;?/:@=&"<>#%{}|\^~[]`' },
                        presence: true

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

    def format_of_origin
      begin  
        uri = URI.parse(origin)
      rescue Exception => e
        errors.add :origin, e.message
      else
        if %w(http https).exclude?(uri.scheme)
          errors.add :origin, 'Must start with \'http://\' or \'https://\'.'
        elsif uri.host.nil?
          errors.add :origin, 'Host can\'t be blank.'
        elsif uri.path == "/#{shortened}" && uri.host == 'zzu.li'
          errors.add :origin, 'Can\'t be the same as the shortened URL.'
        end
      end  

      # match_data = origin.match(URI::regexp(%w(http https))) || []
      # if match_data[1].nil? 
      #   errors.add :origin, 'Must start with \'http://\' or \'https://\'.'
      # elsif match_data[4].nil?
      #   errors.add :origin, 'Host can\'t be blank.'
      # elsif match_data[7] == "/#{shortened}" && match_data[4] == 'zzu.li'
      #   errors.add :origin, 'Can\'t be the same as the shortened URL.'
      # end
      # 1: scheme, 2: opaque, 3: userinfo, 4: host, 5: port, 6: registry, 7: path, 8: query, 9: fragment
    end
end
