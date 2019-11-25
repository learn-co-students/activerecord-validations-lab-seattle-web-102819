class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 100 }
    validates :summary, length: { maximum: 100 }
    validates :category, inclusion: { in: ["Fiction", "Non-Fiction"]}
    validate :clickbait?

    # ALL CAPS, why? Regex, why?
    CLICKBAIT_PHRASES = [/Won't Believe/, /Secret/, /Top[0-9]/, /Guess/]

    # custom methods
    def clickbait?
        if CLICKBAIT_PHRASES.none? { |t| t.match title}
            errors.add(:title, "not clickbait")
        end
    end
end
