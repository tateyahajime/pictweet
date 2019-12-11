class Tweet < ApplicationRecord
  #バリデーション　データを登録する際に、一定の制約をかけること。例えば、空のデータが登録できないようにしたり、文字数制限をかけたりなど。記述する時はモデルに書きます。
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end

  # def self.search(search)
  #   if search
  #     Tweet.where('text LIKE(?)', "%#{search}%")
  #   else
  #     Tweet.all
  #   end
  # end

end
