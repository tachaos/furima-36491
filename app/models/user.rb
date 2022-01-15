class User < ApplicationRecord
  has_many :items
  has_many :sellers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  with_options format: { with: PASSWORD_REGEX, message:'is invalid. Include both letters and numbers' }, confirmation: true do
    validates :password
  end
  validates :nickname, presence: true
  validates :birth_date, presence: true
  with_options presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'is invalid. Input full-width characters' } do
    validates :family_name
    validates :first_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :family_name_kana
    validates :first_name_kana
  end
end
