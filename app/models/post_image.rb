class PostImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def get_image#画像が設定されない場合はapp/assets/imagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納し、格納した画像を表示する
    unless image.attached?#ifのfalseバージョン
      file_path = Rails.root.join('app/assets/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default_image.jpg',content_type: 'image/jpeg')#attach=付ける
    end
    image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
