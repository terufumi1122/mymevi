# == Schema Information
#
# Table name: habits
#
#  id          :bigint           not null, primary key
#  best        :integer          not null
#  description :text(65535)      not null
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  user_id     :integer          not null
#

class Habit < ApplicationRecord
  require 'base64'

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :eyecatch

  attr_accessor :image

  def eyecatch=(image) #eyecatchメソッドを定義する。imageをeyecatchに代入する
    if image.present? #imageが存在する場合は以下を実行
      prefix = image[/(image|application)(\/.*)(?=\;)/] #prefixをBase64でエンコードした文字列の中から正規表現で抜き出す
      if prefix.blank?
        #ここにfilenameを変数で持ってこれないか？
        FileUtils.rm("#{Rails.root}/tmp/#{@filename}") #一時ファイルを削除
        return
      end
      type = prefix.sub(/(image|application)(\/)/, '') #画像の拡張子をprefixから正規表現で抜き出す
      
      data = Base64.decode64(image.sub(/data:#{prefix};base64,/, '')) #Vue.js側でエンコードした文字列をデコードする
      
      @filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{type}" #現在時刻でファイル名作成
      File.open("#{Rails.root}/tmp/#{@filename}", 'wb') do |f|
        f.write(data) #デコードした画像データを作成したファイルに書き込み
      end
      eyecatch.detach # if eyecatch.attached? ←不要。
      #この下のeyecatchで、この定義自体が呼ばれてしまい、nilエラーが出てる。(2/3現在if文で応急処置)
      eyecatch.attach(io: File.open("#{Rails.root}/tmp/#{@filename}"), filename: @filename) #ここでeyecatchメソッドが再帰的に呼び出されてしまっている
    end
  end
end
