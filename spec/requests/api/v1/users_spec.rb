require 'rails_helper'

describe 'PostAPI' do
  it '全てのユーザーを取得する' do
    FactoryBot.build_list(:users, 10)

    get '/api/v1/users'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 正しい数のデータが返されたか確認する。
    expect(json['data'].length).to eq(10)
  end

  it 'URLが違うのでテストに失敗する' do
    get '/api/v2/users'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(400)
  end
end