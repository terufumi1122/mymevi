require 'active_support'

module Base64Module
  extend ActiveSupport::Concern

  require 'base64'

  # Base64でエンコードされた画像ファイルを各モデルのレコードに添付する
  def parse_base64(image_file, image)
    if image.present? || rex_image(image) == ''
      content_type = create_extention(image) # privateメソッドに切り分け
      decoded_data = Base64.decode64(image.sub(/data:#{rex_image(image)};base64,/, '')) # Vue.js側でエンコードしたBase64文字列をデコードし、画像ファイルに戻す
      filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{content_type}" # 現在時刻でファイル名作成
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f| # tmp/ディレクトリにファイルを仮作成
        f.write(decoded_data) # デコードした画像データを作成したファイルに書き込み
      end
    end
    attach_image(image_file, filename)
  end

  # 各モデルのレコードに添付された画像ファイルをBase64でエンコードする
  def encode_base64(image_file)
    image = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
    blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
    "data:#{blob[:content_type]};base64,#{image}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
  end

  private

  def create_extention(image)
    prefix = rex_image(image) # prefixをBase64でエンコードした文字列の中から正規表現で抜き出す
    prefix.sub(%r{(image|application)(/)}, '') # 画像の拡張子をprefixから正規表現で抜き出す
  end

  def rex_image(image)
    image[%r{(image|application)(/.*)(?=\;)}]
  end

  def attach_image(image_file, filename)
    image_file.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename) # デコードした画像データファイルを添付する
    FileUtils.rm("#{Rails.root}/tmp/#{filename}") # 作業用に作成した一時ファイルを削除
  end
end
