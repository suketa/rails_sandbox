class User < ApplicationRecord
  # PNG フォーマットのヘッダー定数を追加
  PNG_FORMAT_HEADER = ['89504E470D0A1A0A'].pack('H*')

  attr_writer :avatar_file # avatar_file を追加

  has_one_attached :avatar

  validates :name, presence: true
  validate :avatar_file_format # validation の追加

  private

  def avatar_file_format
    if @avatar_file.present?
      header = File.read @avatar_file, 8 # ちょい足し機能の確認
      if header != PNG_FORMAT_HEADER
        errors.add(:avatar, 'is not png format file')
      end
    end
  end
end
